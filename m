Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD36FFCEDB
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 20:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKNTmi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 14:42:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36048 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfKNTmi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Nov 2019 14:42:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so4450013pgh.3;
        Thu, 14 Nov 2019 11:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xREiFSWcPI1chhBi4DLb96WHUmNYxgUaObZlX9ct32s=;
        b=RqQ1/TaigRFRI/T+wCoz5yQ/SAOH68FOaVXZGcIlLVoRQGNR2qjXJpy+qkqSag12GQ
         TvKjacB8VJfHwyddFEts3dNAhavwJj4aXdn1yTlr6HykjbM6+tw7b2JE1RQsF/wRnzd1
         poyIPDTdKn35ixj3J75x0OpLcP95KtFJknfADoa4gsngqjy2PxpH+jVasTSu9iIgVhQU
         0vYvAHQ/lmQ8l/05JuoMpZLGaznBS8fWi3WT0tB1x3Gb1KkKu3VnhQQYxoGuKZCJWpWA
         EAXN24vuziaCvLgLepTlzoTokFTIDXpmIs0yi7DcsF744HuVA2peF55r/P9McEp391Pj
         l4+Q==
X-Gm-Message-State: APjAAAXYnO0m7n9cxbuV4p2Dgp8RTGNQn6e7GWTShQMjrfz+/e4M173w
        enSVQFoeFD0HoydIm6SdxoI=
X-Google-Smtp-Source: APXvYqzHzrMhVUuOmrOcvLurwFjLtxHMm3bi+6VC0x6/lYAs2TDGf9BuvH95YORH/zvzQl05Qrz/4g==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr14680183pjq.52.1573760555946;
        Thu, 14 Nov 2019 11:42:35 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o15sm12166006pgf.2.2019.11.14.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:42:34 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BBC3D403DC; Thu, 14 Nov 2019 19:42:33 +0000 (UTC)
Date:   Thu, 14 Nov 2019 19:42:33 +0000
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
Message-ID: <20191114194233.GE11244@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-3-hdegoede@redhat.com>
 <20191011144834.GL16384@42.do-not-panic.com>
 <e7bd40ff-20d1-3aed-8516-9fffd4c3a207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7bd40ff-20d1-3aed-8516-9fffd4c3a207@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 14, 2019 at 12:27:01PM +0100, Hans de Goede wrote:
> Hi Luis,
> 
> Thank you for the reviews and sorry for being a bit slow to respind.
> 
> On 11-10-2019 16:48, Luis Chamberlain wrote:
> > On Fri, Oct 04, 2019 at 04:50:50PM +0200, Hans de Goede wrote:
> > > +static int __init efi_check_md_for_embedded_firmware(
> > > +	efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
> > > +{
> > > +	const u64 prefix = *((u64 *)desc->prefix);
> > > +	struct sha256_state sctx;
> > > +	struct embedded_fw *fw;
> > > +	u8 sha256[32];
> > > +	u64 i, size;
> > > +	void *map;
> > > +
> > > +	size = md->num_pages << EFI_PAGE_SHIFT;
> > > +	map = memremap(md->phys_addr, size, MEMREMAP_WB);
> > 
> > Since our limitaiton is the init process must have mostly finished,
> > it implies early x86 boot code cannot use this, what measures can we
> > take to prevent / check for such conditions to be detected and
> > gracefully errored out?
> 
> As with all (EFI) early boot code, there simply is a certain order
> in which things need to be done. This needs to happen after the basic
> mm is setup, but before efi_free_boot_services() gets called, there
> isn't really a way to check for all these conditions. As with all
> early boot code, people making changes need to be careful to not
> break stuff.

I rather we take a proactive measure here and add whatever it is we need
to ensure the API works only when its supposed to, rather than try and
fail, and then expect the user to know these things.

I'd prefer if we at least try to address this.

> > > +	if (!map) {
> > > +		pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	size -= desc->length;
> > 
> > Remind me again, why we decrement the size here?
> 
> Basically this is another way of writing:
> 
> 	for (i = 0; (i + desc->length) < size; i += 8) {
> 
> > I was going to ask if we didn't need a:
> > 
> > if (desc->length > size) {
> > 	memunmap(map);
> > 	return -EINVAL;
> > }
> 
> That is a good point, unlikely but still a good point,
> so I guess that writing:
> 
> 	for (i = 0; (i + desc->length) < size; i += 8) {
> 
> Instead would better as that avoids the need for that check.
> I will fix this for the next version.

Great thanks.

  Luis
