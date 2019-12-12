Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA311D8D6
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 22:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfLLVx4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 16:53:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37640 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfLLVx4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 16:53:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so4430400wru.4
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 13:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25CqBgMwE1hC+JnjyLfvp+a67jgnLgm8ZEuA0+GMmIA=;
        b=y938Vrg0IGKlbIljBTRS8skySxpRL+Mry1Wwsv7fGoiItJub+5gPWfuj5uwc3vv2d/
         NuOWHwpLZpUUne4SUbwsA0h9NDlRSDv4rdzAH+30pdx9XWBpBnHk5T3udmWJBOJ6O84U
         STATO6pTfTVlyMkxMlLTpyNE2bm0hOOQqRvBpROH6O91Uu5XGo6dswWGwl5jChETde37
         o73oL9xBp4UC0pSG57DPZDGFkZGPyqMkecps4Wor0tMvKrXgCP1/ApTVTz3NCH3/HT01
         lOXnB4N30F8/4wngzqktOXwSjrKgLUn1s3UBR6FwEbt+AarnAbk3cbbr872zyiegDSjB
         kAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25CqBgMwE1hC+JnjyLfvp+a67jgnLgm8ZEuA0+GMmIA=;
        b=E8xufMJdt1G+mIZVtu/5BCdX8Gsc0sXna6rbWSbLuKNcpdGiz/bFwtD+01c/P3jyja
         omg4naH4kU5p36im5Y0TxpccIH2RfmHRrleSY5B4WfOx6R7hBdHVdj0o+x+bUTLVnQmT
         YJRIJqvDl7QrbwnBLXlbf1v1XiCL2CrU8JZmcunwGWO9tznBbVjjLIc+YjVE3P1+2zWX
         QMofXJIRdZuoUPmcRxgKvbNCqP8CRLIXCDr+6zmsaQgPI56/5eyDOlCGUSWWtplAWyfT
         BkXx+0TvGkNRhlh/cX1+QsHDBGp7p1rIbE/rFkcVpeAcjfFswMasKAtAqDBgeNEuJMAk
         X9cg==
X-Gm-Message-State: APjAAAW2SROUS5nnia0NZ2vjb+0mPWcKtQmVjnJmpvxpl5HqE1TyzHR8
        d81lEDyD0doj9aLkYsT8TVUzADDZ0/mFstfl8gc53g==
X-Google-Smtp-Source: APXvYqxZpUAzi+7PZNdAUoJeWIBLmpn6NSb4r5g4XPu6DddtQi3mTZBjUHdLi0cdCjkj7x6AqkqlEIe+tRaeJMVj1G0=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr8532038wrs.200.1576187634024;
 Thu, 12 Dec 2019 13:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20191212213443.24128-1-nivedita@alum.mit.edu> <20191212213443.24128-2-nivedita@alum.mit.edu>
In-Reply-To: <20191212213443.24128-2-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 21:53:52 +0000
Message-ID: <CAKv+Gu-EyfeNDB1NbQiOEJAvWpkFc7KrHvDjtKrFyOC8y-cd0g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] efi/gop: Remove bogus packed attribute from GOP structures
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Dec 2019 at 22:34, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> EFI structures are not packed, they follow natural alignment.
>
> The packed attribute doesn't have any effect on the structure layout due
> to the types and order of the members, and we only ever get these
> structures as output from the EFI firmware so alignment issues have not
> come up.
>

__packed may also affect the size of a struct, given that it won't be
rounded up to its alignment. This broke the config table array at some
point when we used the alignment for EFI_GUIDs that is actually
mentioned in the spec.

In this particular case, I think your analysis is correct wrt the
types in question, just be aware that padding is not the complete
picture.


> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  include/linux/efi.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 99dfea595c8c..bffe6e0a9b53 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1429,7 +1429,7 @@ struct efi_graphics_output_mode_info {
>         int pixel_format;
>         struct efi_pixel_bitmask pixel_information;
>         u32 pixels_per_scan_line;
> -} __packed;
> +};
>
>  struct efi_graphics_output_protocol_mode_32 {
>         u32 max_mode;
> @@ -1438,7 +1438,7 @@ struct efi_graphics_output_protocol_mode_32 {
>         u32 size_of_info;
>         u64 frame_buffer_base;
>         u32 frame_buffer_size;
> -} __packed;
> +};
>
>  struct efi_graphics_output_protocol_mode_64 {
>         u32 max_mode;
> @@ -1447,7 +1447,7 @@ struct efi_graphics_output_protocol_mode_64 {
>         u64 size_of_info;
>         u64 frame_buffer_base;
>         u64 frame_buffer_size;
> -} __packed;
> +};
>
>  struct efi_graphics_output_protocol_mode {
>         u32 max_mode;
> @@ -1456,7 +1456,7 @@ struct efi_graphics_output_protocol_mode {
>         unsigned long size_of_info;
>         u64 frame_buffer_base;
>         unsigned long frame_buffer_size;
> -} __packed;
> +};
>
>  struct efi_graphics_output_protocol_32 {
>         u32 query_mode;
> --
> 2.23.0
>
