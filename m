Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA591FAF00
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPLTV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPLTU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Jun 2020 07:19:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B9C08C5C2
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 04:19:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so20353184wru.6
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WwC2Emuw5/ilnMRm4G3eM8wt43KxbXAl63WH+7ihd3U=;
        b=X1yeojWj8vFgyVUXSv2DkkgdcvgwcOwt8tq8Yh3keBKJmhffFGsEkx1645NnGtGIJc
         yMZ4Z6NaWxUP1HAyHkk6BtFvzi3WLG4fQHod69NFzwzwsEA1nKQLHD63Io5iSYeAVtW1
         pfesWyQpi80mAt5cBymvoejWV3ibyl64fgbFYqQUjEIcsrK67F5rrFXJFZO6JivBUQ/Z
         /J+vtiBKh6SxakJwq04sdJVNVKUeAUQVHYY0ZFkWwRJQILysyTCbd/yxVe40VfB1bTRi
         ZOJX62T7FSS1osOzS00FvSeoWwBjxoLTHffjpK2gw70h/QFeQDedaMbiULBG6ZlJiACz
         C0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WwC2Emuw5/ilnMRm4G3eM8wt43KxbXAl63WH+7ihd3U=;
        b=Sr1kCkGWj15ADwLqVYvf5ykbmzqRrYn467YZZxHJdeJTe4qyFpb1sNqhnMugqd/COD
         3VaZ18TaTBwYlt/6WEmuswGbVlNqiORMRGwzphLHiEFxXyeuz9tRN+94DNSCjR/mgyDQ
         O6StK+w1cAhCdMSnTPr5DymlbIvLRDTsJAvVtz5Gx6vujTZ+Gn4yqkDV5LKROoVygl0v
         aQ4RbJO1txUTA9XR7AhGE0Cl7tZokjWnhpZBK3JRJOKfbn7Qq/lAZ3BpwYkGaGT4kDJS
         rq+bavG6M+AwG0T9EcWSMTnIZ4B4BN4Y+bdhgpUt5aSttaTw/6a1NHnn5c9cOaySoJFB
         orrw==
X-Gm-Message-State: AOAM531x201QU5RKQZnLfHiw/QN/2pZWG0el4Zc3umsVvFyoq7jY3zLq
        yp89ijhgALGchn3gBtTVVV/DZg==
X-Google-Smtp-Source: ABdhPJzpxJzOiDXP2NRlBv/phRFjDMCxcTzQOKN5dBK8VrJPmUTOe+rdbOl9hkQdEvXZ95AgSS2sBA==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr2488839wrs.223.1592306357384;
        Tue, 16 Jun 2020 04:19:17 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
        by smtp.gmail.com with ESMTPSA id z2sm27560929wrs.87.2020.06.16.04.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 04:19:16 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:19:14 +0100
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        xypron.glpk@gmx.de
Subject: Re: [PATCH] efi/libstub: arm: Omit arch specific config table
 matching array on arm64
Message-ID: <20200616111914.GD6739@vanye>
References: <20200616110030.1054015-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616110030.1054015-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 16, 2020 at 13:00:30 +0200, Ard Biesheuvel wrote:
> On arm64, the EFI stub is built into the kernel proper, and so the stub
> can refer to its symbols directly. Therefore, the practice of using EFI
> configuration tables to pass information between them is never needed,
> so we can omit any code consuming such tables when building for arm64.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> ---
> 
> This will be applied before 'efi/libstub: arm: Print CPU boot mode and MMU 
> state at boot' [v3] sent out today

With that, for *both* patches:
Reviewed-by: Leif Lindholm <leif@nuviainc.com>

>  drivers/firmware/efi/arm-init.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index c697e70ca7e7..6f4baf70db16 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -62,7 +62,8 @@ static void __init init_screen_info(void)
>  {
>  	struct screen_info *si;
>  
> -	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
> +	if (IS_ENABLED(CONFIG_ARM) &&
> +	    screen_info_table != EFI_INVALID_TABLE_ADDR) {
>  		si = early_memremap_ro(screen_info_table, sizeof(*si));
>  		if (!si) {
>  			pr_err("Could not map screen_info config table\n");
> @@ -116,7 +117,8 @@ static int __init uefi_init(u64 efi_system_table)
>  		goto out;
>  	}
>  	retval = efi_config_parse_tables(config_tables, systab->nr_tables,
> -					 arch_tables);
> +					 IS_ENABLED(CONFIG_ARM) ? arch_tables
> +								: NULL);
>  
>  	early_memunmap(config_tables, table_size);
>  out:
> -- 
> 2.27.0
> 
