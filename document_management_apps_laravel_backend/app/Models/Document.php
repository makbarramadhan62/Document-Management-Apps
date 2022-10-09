<?php

namespace App\Models;

use App\Models\Status;
use App\Models\Category;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Document extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    static function getDocument()
    {
        $return = DB::table('documents')
            ->join('users', 'documents.user_id', 'users.id')
            ->join('categories', 'documents.category_id', 'categories.id')
            ->select('documents.*', 'users.username', 'categories.category_name')
            ->get();
        return $return;
    }

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    public function status()
    {
        return $this->belongsTo(Status::class, 'status_id');
    }

    public function type()
    {
        return $this->belongsTo(Type::class, 'type_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
