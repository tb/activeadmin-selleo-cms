class ChangeActiveadminSelleoCmsSearches < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      DROP VIEW activeadmin_selleo_cms_searches
    SQL
    ActiveRecord::Base.connection.execute <<-SQL
    CREATE VIEW activeadmin_selleo_cms_searches AS
      SELECT
        'ActiveadminSelleoCms::Page' AS searchable_type,
        pages.id AS searchable_id,
        pages.is_published ,
        page_translations.locale,
        coalesce(string_agg(page_translations.title, ' '), '')||' '||coalesce(string_agg(section_translations.body, ' '), '') as content
      FROM
        activeadmin_selleo_cms_pages pages
      INNER JOIN
        activeadmin_selleo_cms_page_translations page_translations ON page_translations.activeadmin_selleo_cms_page_id = pages.id
      LEFT JOIN
        activeadmin_selleo_cms_sections sections ON sections.sectionable_id = pages.id AND sections.sectionable_type = 'ActiveadminSelleoCms::Page'
      LEFT JOIN
        activeadmin_selleo_cms_section_translations section_translations ON section_translations.activeadmin_selleo_cms_section_id = sections.id AND section_translations.locale = page_translations.locale
      GROUP BY
        pages.id, page_translations.locale
    SQL
  end

  def down
  end
end
