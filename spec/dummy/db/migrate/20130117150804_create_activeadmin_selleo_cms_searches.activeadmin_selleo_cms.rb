# This migration comes from activeadmin_selleo_cms (originally 20121221164723)
class CreateActiveadminSelleoCmsSearches < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
    CREATE VIEW activeadmin_selleo_cms_searches AS
      SELECT
        'ActiveadminSelleoCms::Page' AS searchable_type,
        page_translations.activeadmin_selleo_cms_page_id AS searchable_id,
        coalesce(page_translations.title,'')||' '||coalesce(page_translations.browser_title,'') AS content,
        page_translations.locale
      FROM
        activeadmin_selleo_cms_page_translations page_translations

      UNION ALL

      SELECT
        'ActiveadminSelleoCms::Page' AS searchable_type,
        sections.sectionable_id AS searchable_id,
        coalesce(section_translations.body,'') AS content,
        section_translations.locale
      FROM
        activeadmin_selleo_cms_section_translations section_translations
      INNER JOIN
        activeadmin_selleo_cms_sections sections
          ON sections.id = section_translations.activeadmin_selleo_cms_section_id
    SQL
  end

  def down
    ActiveRecord::Base.connection.execute <<-SQL
      DROP VIEW activeadmin_selleo_cms_searches
    SQL
  end
end
