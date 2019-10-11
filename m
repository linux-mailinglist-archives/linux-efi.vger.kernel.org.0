Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3ABCD4360
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfJKOsh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 10:48:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36137 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKOsh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 10:48:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so6242533pfr.3;
        Fri, 11 Oct 2019 07:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iPc5NZD98rq6lmQmCZyD8Q7eBmoCyRmt8Bt4JVgrKYo=;
        b=X7ACOdrrOwaKaQILEcyWGQJ3CcY3Hmwo/l29HtfZACmaXT2h7OrovRtt0ULpoR20Ke
         W8h3O3wrVhJ9iz/xwUbW7l/gZ0rXycOaMTIKPQuWY4KL4/jMC3jCWl5VdGgXMVL6aCoT
         PuSpZrOdsve3wBlNRriC0hXWfK56BOvR816MaZPt86bYD4inPUGtdSX537fatuJIUxl5
         BBBtHbruwTcZ+Po2Y5EBjpYzqwjp98GVqchOa0osffxygOBrbDNpk6RKKboWFXt9pweR
         7y15vmvkaGPow/Q7gI6+WAiC4ggfQuIvPhu3oX7snLgT/JwTJcGDdBuZyLharr0XOs9J
         ONnA==
X-Gm-Message-State: APjAAAWSHf7OzmP7t7e8iejXeWJNObtgx6pATQEJ0BK+1wpKWnnXVsoM
        2YWSP/qNIG8uPRl0VBrwS/s=
X-Google-Smtp-Source: APXvYqzUrZcbx+ZWRjUoweN3gS8eeZhjKA3OdK5K+Zw6lT7R/kHLFmtnbH3pcVRrCWmlWUzEIX8jWQ==
X-Received: by 2002:a63:5406:: with SMTP id i6mr13547064pgb.1.1570805316463;
        Fri, 11 Oct 2019 07:48:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 7sm8008752pgj.35.2019.10.11.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:48:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 98CF6403EA; Fri, 11 Oct 2019 14:48:34 +0000 (UTC)
Date:   Fri, 11 Oct 2019 14:48:34 +0000
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
Subject: Re: [PATCH v7 2/8] efi: Add embedded peripheral firmware support
Message-ID: <20191011144834.GL16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-3-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:50PM +0200, Hans de Goede wrote:
> +static int __init efi_check_md_for_embedded_firmware(
> +	efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
> +{
> +	const u64 prefix = *((u64 *)desc->prefix);
> +	struct sha256_state sctx;
> +	struct embedded_fw *fw;
> +	u8 sha256[32];
> +	u64 i, size;
> +	void *map;
> +
> +	size = md->num_pages << EFI_PAGE_SHIFT;
> +	map = memremap(md->phys_addr, size, MEMREMAP_WB);

Since our limitaiton is the init process must have mostly finished,
it implies early x86 boot code cannot use this, what measures can we
take to prevent / check for such conditions to be detected and
gracefully errored out?

> +	if (!map) {
> +		pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
> +		return -ENOMEM;
> +	}
> +
> +	size -= desc->length;

Remind me again, why we decrement the size here?
I was going to ask if we didn't need a:

if (desc->length > size) {
	memunmap(map);
	return -EINVAL;
}

> +	for (i = 0; i < size; i += 8) {
> +		u64 *mem = map + i;
> +
> +		if (*mem != prefix)
> +			continue;
> +
> +		sha256_init(&sctx);
> +		sha256_update(&sctx, map + i, desc->length);
> +		sha256_final(&sctx, sha256);
> +		if (memcmp(sha256, desc->sha256, 32) == 0)
> +			break;
> +	}
> +	if (i >= size) {
> +		memunmap(map);
> +		return -ENOENT;
> +	}
> +
> +	pr_info("Found EFI embedded fw '%s'\n", desc->name);

Otherwise looks good.

  Luis
