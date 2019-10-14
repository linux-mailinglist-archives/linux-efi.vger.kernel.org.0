Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B48D5E58
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfJNJLh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 05:11:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39843 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfJNJLh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Oct 2019 05:11:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so7734879plp.6;
        Mon, 14 Oct 2019 02:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IFRxy6xr/cn5i5eJ5LyoCFcrnq8otJ7MI3Vnt7AQmQ=;
        b=U826a941vtbfZP0+j8BWQZoMRB+iHWVT8hr9rJiFYjQnuJktsDEGBeYNQsnSgXxtfG
         T/UsJswL1tAo17YDzOX2nVbdvuQpMomIO/TpVsS3WJESRehEkXCfX+oADAJ1DNaX2/4v
         hhJToE9Sa41G7QWuwjE5pnQW0CEOkUhKU9/VilOYdDcErh6LvA0XesmQrtubXFrc6IUQ
         oqL1y5WgErKBFrUbif9ysuXANdQb6idsl/3jXMJHbh0t6C5dQzU9OZACeSVwh5xjxd+B
         yNhmLqyJHTYGUQNFHa+J03ZvPzE1mcnREdOvibece0xM24telG5kjQiEbaG+H3Nc18Ya
         CRAg==
X-Gm-Message-State: APjAAAUEg7Jk/UKtfHtv8w8MZYXg4x0hJXagP8QPo/e7YaohxiiVMo7z
        b7RPpWvbPxuD+Boa1e+r8cQ=
X-Google-Smtp-Source: APXvYqzqz+mYzu6Rr6fKvuJ7evMkxLlZvgFgPvKfodKwNGTJg2ZtQUysAWGF3WWCCK+xvwrnrs5+ZA==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr28734080plq.177.1571044296067;
        Mon, 14 Oct 2019 02:11:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s1sm16973494pjs.31.2019.10.14.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 02:11:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0A8564021A; Mon, 14 Oct 2019 09:11:33 +0000 (UTC)
Date:   Mon, 14 Oct 2019 09:11:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v7 1/8] efi: Export boot-services code and data as
 debugfs-blobs
Message-ID: <20191014091133.GY16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-2-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:49PM +0200, Hans de Goede wrote:
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 8d3e778e988b..abba49c4c46d 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -314,6 +315,55 @@ static __init int efivar_ssdt_load(void)
>  static inline int efivar_ssdt_load(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define EFI_DEBUGFS_MAX_BLOBS 32
> +
> +static struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
> +
> +static void __init efi_debugfs_init(void)
> +{
> +	struct dentry *efi_debugfs;
> +	efi_memory_desc_t *md;
> +	char name[32];
> +	int type_count[EFI_BOOT_SERVICES_DATA + 1] = {};
> +	int i = 0;
> +
> +	efi_debugfs = debugfs_create_dir("efi", NULL);
> +	if (IS_ERR_OR_NULL(efi_debugfs))
> +		return;
> +
> +	for_each_efi_memory_desc(md) {
> +		switch (md->type) {
> +		case EFI_BOOT_SERVICES_CODE:
> +			snprintf(name, sizeof(name), "boot_services_code%d",
> +				 type_count[md->type]++);
> +			break;
> +		case EFI_BOOT_SERVICES_DATA:
> +			snprintf(name, sizeof(name), "boot_services_data%d",
> +				 type_count[md->type]++);
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		debugfs_blob[i].size = md->num_pages << EFI_PAGE_SHIFT;
> +		debugfs_blob[i].data = memremap(md->phys_addr,
> +						debugfs_blob[i].size,
> +						MEMREMAP_WB);
> +		if (!debugfs_blob[i].data)
> +			continue;
> +
> +		debugfs_create_blob(name, 0400, efi_debugfs, &debugfs_blob[i]);
> +		i++;
> +		if (i == EFI_DEBUGFS_MAX_BLOBS)
> +			break;

Why do we silently ignore more entries ? And could documentation be
added for ways in which this could be used in practice?

  Luis
