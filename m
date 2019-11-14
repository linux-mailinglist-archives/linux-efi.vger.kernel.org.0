Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE9FD08F
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 22:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNVuN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 16:50:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40813 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNVuN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Nov 2019 16:50:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id e3so3259353plt.7;
        Thu, 14 Nov 2019 13:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5zMHwUOo/2U4wTRnnNuzptX3ll72MK4baxH2uMM1XNw=;
        b=HlNKU0+W0fRBgy+CvKyNpM/ODMBTouSBLf6Y0YWbGEIa+x3anPCoU4iqxoK90OSpBu
         U1w7dlIc0n35tyxghxBnyEHgQ2BCyxw+as3BPg5rRi4OaVZn5OTrfJ7Dpx5z2BnJDzPk
         4Thstk76JNZPVXpOZl9v8/qaMoz7hYr+ulHknJrGY1/AVbOQ8QrjSjV3x58HvV7NzEFs
         JAvkRuIxMrD9bo699sYfg8SRewYnR1P+g3kFZqhPI+LXCtZQ8z+hdg3asoybnJYzQ3f/
         eDRpCoR8mkqfCtVB+eV6Ue1CaSV9CnphyY9ueroCPbGgSMhukg6IyqK28AIA9MxenvDt
         M9qg==
X-Gm-Message-State: APjAAAVjFEUn0rraWjefHKeQzD08aFV8vFNMUIQq21QHzrJ8AIF7O0mh
        cWTi65CE7VAgpRDMincqPpk=
X-Google-Smtp-Source: APXvYqydj/PhwGbb7+FBeWT/qX73FpfeKzIGfeaJLVypBktgbTiIoqJ5tWmafcGyCmnkRQDn0qoNOA==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr11133218plt.164.1573768211636;
        Thu, 14 Nov 2019 13:50:11 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f31sm10455021pjg.31.2019.11.14.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 13:50:09 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3DCB6403DC; Thu, 14 Nov 2019 21:50:09 +0000 (UTC)
Date:   Thu, 14 Nov 2019 21:50:09 +0000
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
Message-ID: <20191114215009.GF11244@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-3-hdegoede@redhat.com>
 <20191011144834.GL16384@42.do-not-panic.com>
 <e7bd40ff-20d1-3aed-8516-9fffd4c3a207@redhat.com>
 <20191114194233.GE11244@42.do-not-panic.com>
 <f00804ae-e556-35e4-d0a3-cd9201fdd2d0@redhat.com>
 <9b0a0121-3e63-0602-6c0d-00547e389f76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b0a0121-3e63-0602-6c0d-00547e389f76@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 14, 2019 at 09:48:38PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 14-11-2019 21:13, Hans de Goede wrote:
> > Hi,
> > 
> > On 14-11-2019 20:42, Luis Chamberlain wrote:
> > > On Thu, Nov 14, 2019 at 12:27:01PM +0100, Hans de Goede wrote:
> > > > Hi Luis,
> > > > 
> > > > Thank you for the reviews and sorry for being a bit slow to respind.
> > > > 
> > > > On 11-10-2019 16:48, Luis Chamberlain wrote:
> > > > > On Fri, Oct 04, 2019 at 04:50:50PM +0200, Hans de Goede wrote:
> > > > > > +static int __init efi_check_md_for_embedded_firmware(
> > > > > > +    efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
> > > > > > +{
> > > > > > +    const u64 prefix = *((u64 *)desc->prefix);
> > > > > > +    struct sha256_state sctx;
> > > > > > +    struct embedded_fw *fw;
> > > > > > +    u8 sha256[32];
> > > > > > +    u64 i, size;
> > > > > > +    void *map;
> > > > > > +
> > > > > > +    size = md->num_pages << EFI_PAGE_SHIFT;
> > > > > > +    map = memremap(md->phys_addr, size, MEMREMAP_WB);
> > > > > 
> > > > > Since our limitaiton is the init process must have mostly finished,
> > > > > it implies early x86 boot code cannot use this, what measures can we
> > > > > take to prevent / check for such conditions to be detected and
> > > > > gracefully errored out?
> > > > 
> > > > As with all (EFI) early boot code, there simply is a certain order
> > > > in which things need to be done. This needs to happen after the basic
> > > > mm is setup, but before efi_free_boot_services() gets called, there
> > > > isn't really a way to check for all these conditions. As with all
> > > > early boot code, people making changes need to be careful to not
> > > > break stuff.
> > > 
> > > I rather we take a proactive measure here and add whatever it is we need
> > > to ensure the API works only when its supposed to, rather than try and
> > > fail, and then expect the user to know these things.
> > > 
> > > I'd prefer if we at least try to address this.
> > 
> > This is purely internal x86/EFI API it is not intended for drivers
> > or anything like that. It has only one caller under arch/x86 and it is
> > not supposed to get any other callers outside of arch/* ever.
> > 
> > Note that this all runs before even core_initcall-s get run, none
> > if the code which runs before then has any sort of ordering checks
> > and I don't see how this bit is special and thus does need ordering
> > checks; and there really is no mechanism for such checks so early
> > during boot.
> > 
> > The drivers/firmware/efi/embedded-firmware.c file does add some API
> > which can be used normally, specifically the efi_get_embedded_fw()
> > but that has no special ordering constrains and it does not directly
> > use the function we are discussing now. It reads back data stored
> > by the earlier functions; and if somehow called before those functions
> > run (*), then it will simply return -ENOENT.
> 
> Ok, I just realized that we may have some miscommunication here,
> when you wrote:
> 
> "Since our limitation is the init process must have mostly finished,
>  it implies early x86 boot code cannot use this, what measures can we
>  take to prevent / check for such conditions to be detected and
>  gracefully errored out?"
> 
> I assumed you meant that to apply to the efi_check_md_for_embedded_firmware()
> helper or its caller.
> 
> But I guess what you really want is some error to be thrown if someone
> calls firmware_request_platform() before we are ready.

Yes.

> I guess I could make efi_check_for_embedded_firmwares() which scans
> for known firmwares and saved a copy set a flag that it has run.
> 
> And then combine that with making efi_get_embedded_fw() (which underpins
> firmware_request_platform()) print a warning when called if that flag
> is not set yet.
> 
> That would mean though that some code which runs earlier then
> a core_initcall would, would call firmware_request_platform() and
> such code is generally expected to know what they are doing.
> 
> I just checked and the cpu microcode stuff which comes to mind
> for this uses a late_initcall so runs long after efi_get_embedded_fw()
> and I have a feeling that trying to use the fw_loader before
> core_initcalls have run is going to end poorly anyways.
>
> Still if you want I can add a pr_warn or maybe even a WARN_ON
> to efi_get_embedded_fw() in case it somehow gets called before
> efi_check_for_embedded_firmwares().

That'd be great.

  Luis
