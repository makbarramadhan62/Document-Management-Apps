<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Type;
use App\Models\User;
use App\Models\Category;
use App\Models\Status;
use App\Models\Document;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);

        User::create([
            'full_name' => 'Admin',
            'username' => 'Admin',
            'email' => 'admin@gmail.com',
            'title' => 'Admin',
            'phone_number' => '081234567890',
            'password' => bcrypt('admin')
        ]);

        Type::create([
            'type_name' => 'DocumentIn'
        ]);

        Type::create([
            'type_name' => 'DocumentOut'
        ]);

        Category::create([
            'category_name' => 'Finance'
        ]);

        Category::create([
            'category_name' => 'Recruitment'
        ]);

        Category::create([
            'category_name' => 'Internship'
        ]);

        Category::create([
            'category_name' => 'Project'
        ]);

        Status::create([
            'status_name' => 'Validated'
        ]);

        Status::create([
            'status_name' => 'UnValidated'
        ]);

        Status::create([
            'status_name' => 'Depreceated'
        ]);

        Document::create([
            'document_name' => 'Permintaan Magang ITTS',
            'organization_name' => 'ITTelkom Surabaya',
            'date' => '10-10-2022',
            'type_id' => '1',
            'category_id' => '2',
            'status_id' => '2',
            'file_upload' => 'file1.pdf',
            'signature' => '',
            'user_id' => '1',
        ]);

        Document::create([
            'document_name' => 'Keuangan Project A',
            'organization_name' => 'PT. Otak Kanan',
            'date' => '04-10-2022',
            'type_id' => '2',
            'category_id' => '4',
            'status_id' => '1',
            'file_upload' => 'file2.pdf',
            'signature' => '',
            'user_id' => '1',
        ]);

        Document::create([
            'document_name' => 'Internship Sekolah B',
            'organization_name' => 'Sekolah B',
            'date' => '04-10-2022',
            'type_id' => '2',
            'category_id' => '4',
            'status_id' => '1',
            'file_upload' => 'file2.pdf',
            'signature' => '',
            'user_id' => '1',
        ]);

        Document::create([
            'document_name' => 'Permintaan Magang UB',
            'organization_name' => 'Universitas Brawijaya',
            'date' => '04-10-2022',
            'type_id' => '2',
            'category_id' => '4',
            'status_id' => '1',
            'file_upload' => 'file2.pdf',
            'signature' => '',
            'user_id' => '1',
        ]);

        Document::create([
            'document_name' => 'Project Perusahaan Kantor A',
            'organization_name' => 'PT. Kantor A',
            'date' => '04-10-2022',
            'type_id' => '2',
            'category_id' => '4',
            'status_id' => '1',
            'file_upload' => 'file2.pdf',
            'signature' => '',
            'user_id' => '1',
        ]);

        Document::create([
            'document_name' => 'Lamaran Kerjaan',
            'organization_name' => 'Personal',
            'date' => '04-10-2022',
            'type_id' => '2',
            'category_id' => '4',
            'status_id' => '1',
            'file_upload' => 'file2.pdf',
            'signature' => '',
            'user_id' => '1',
        ]);

        Document::create([
            'document_name' => 'Permintaan Lamaran Kerjaan',
            'organization_name' => 'Personal',
            'date' => '04-10-2022',
            'type_id' => '2',
            'category_id' => '4',
            'status_id' => '1',
            'file_upload' => 'file2.pdf',
            'signature' => '',
            'user_id' => '1',
        ]);
    }
}
