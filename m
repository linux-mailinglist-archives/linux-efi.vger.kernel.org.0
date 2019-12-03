Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB710FD82
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 13:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfLCMVg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 07:21:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36696 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCMVg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 07:21:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3249148wma.1
        for <linux-efi@vger.kernel.org>; Tue, 03 Dec 2019 04:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agHyjTjbofzuW8SIwTIdiL9YenKtJD2wlWpQCg4YmqM=;
        b=IyoeuQiIyAeqePQ/Vfu8MwxYbFJ/qMit3p/kgl+cVH3Y0T/ldi6h5YuHv5B6msXy6V
         ygU3o+ojfitdMSzBiaqOHWI+r9Lhfi1jOYRFnNpxlv5Y9jc/OpbjW/tdedyKpMlQBd1w
         D0O8+C/8mol0whKUwVJT95qG1FIjFD8on2XpXWN7TgAr3jVRTjTrOvKoP4RKrsQ206pi
         xn9ggtomHDs2RNJOnbQpNPJqtjyF6jpeo+cquZouJG7hvULGK445GCBrAtFh7iTKv2sE
         UDaQUCOdYbTGodVkYcjD47Al1JhBqdQxCV+zYRlp4oj9qzcueI4djRNdQTcGj1MBHGYz
         s3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agHyjTjbofzuW8SIwTIdiL9YenKtJD2wlWpQCg4YmqM=;
        b=HQfNmbt4R/yhGhoBM0A7MDek1VAkEqa88T5S6LXS1ixkio3fVUJJHQqlNdEX1818qa
         XDHTu8fPJ9GIMAs75D5CIhcdylARJ6i4hyzD08TpX7iUTR/ZYfrYApAmof9aE3ua20Km
         aKLKUE1xd2sX168kLmmTBfKvJxLzzsNX7zXwmlm0Dm6h3+ZU4ghmg+hKgz73kIBSncCq
         hhmK9TEGYO8Ix/7rseNRPS4ylbxHgIrUDGmbGfMiRA3G+aAw4d2UNZ2GEtqB3CL40dzK
         D/FiBHNvCJOQC6sO0ADIUyvBnXlKHi8o1p19zFE4p521rpf/qZ2PiR++wmPSd/qWCK5W
         +SxA==
X-Gm-Message-State: APjAAAVs1BHtHbd6nJF4msyApIgzLW/JVEJADZ3eVoR6cM4u4o0MVM7y
        4LvloCKEaCeT7XEZ116nKPkz4S5HGJA34DBk70GZTOeUqSesjA==
X-Google-Smtp-Source: APXvYqy0cPGOP724txYz8qFtRgOzBhqL+Hsj7n+zraMo2AmPX8FGijMgotqh3LQ+y8ZRGJC/E9J31XgdwKwgCeQP9V8=
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr34766041wmf.10.1575375694173;
 Tue, 03 Dec 2019 04:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20191201221058.831985-1-nivedita@alum.mit.edu>
In-Reply-To: <20191201221058.831985-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 3 Dec 2019 12:21:29 +0000
Message-ID: <CAKv+Gu8Lih6q7yVJ0Mbz8a0DoxdPdqBpue+Vh7b4aMgn9kZ=AA@mail.gmail.com>
Subject: Re: [PATCH] efi: fix type of unload field in efi_loaded_image_t
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 1 Dec 2019 at 22:11, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The unload field is a function pointer, so it should be u32 for 32-bit,
> u64 for 64-bit. Add a prototype for it in the native efi_loaded_image_t
> type. Also change type of parent_handle and device_handle from void* to
> efi_handle_t for documentation purposes.
>
> The unload method is not used, so no functional change.

Please resend this patch with a signed-off-by line, and I will queue
it for the next merge window.


> ---
>  include/linux/efi.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 99dfea595c8c..aa54586db7a5 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -824,7 +824,7 @@ typedef struct {
>         __aligned_u64 image_size;
>         unsigned int image_code_type;
>         unsigned int image_data_type;
> -       unsigned long unload;
> +       u32 unload;
>  } efi_loaded_image_32_t;
>
>  typedef struct {
> @@ -840,14 +840,14 @@ typedef struct {
>         __aligned_u64 image_size;
>         unsigned int image_code_type;
>         unsigned int image_data_type;
> -       unsigned long unload;
> +       u64 unload;
>  } efi_loaded_image_64_t;
>
>  typedef struct {
>         u32 revision;
> -       void *parent_handle;
> +       efi_handle_t parent_handle;
>         efi_system_table_t *system_table;
> -       void *device_handle;
> +       efi_handle_t device_handle;
>         void *file_path;
>         void *reserved;
>         u32 load_options_size;
> @@ -856,7 +856,7 @@ typedef struct {
>         __aligned_u64 image_size;
>         unsigned int image_code_type;
>         unsigned int image_data_type;
> -       unsigned long unload;
> +       efi_status_t (*unload)(efi_handle_t image_handle);
>  } efi_loaded_image_t;
>
>
> --
> 2.23.0
>
