<?php

use App\Http\Controllers\CategoryController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\UserController;


Route::get('/dashboard', function () {
  return view('dashboard.index');
});

Route::resource('/dashboard/documents', DocumentController::class);
Route::resource('/dashboard/users', UserController::class);
Route::resource('/dashboard/categories', CategoryController::class);
