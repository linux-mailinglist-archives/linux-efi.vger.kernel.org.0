Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED80112F919
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 15:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgACORC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 09:17:02 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37666 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbgACORB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jan 2020 09:17:01 -0500
Received: by mail-qv1-f65.google.com with SMTP id f16so16263454qvi.4
        for <linux-efi@vger.kernel.org>; Fri, 03 Jan 2020 06:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i0orxC0f9GEHv/18++7WN43Uk702gBVzndKRdF7rXHA=;
        b=KXZKxgfvQShC90U5S4/fRRh2WT26aX5m22QbSaOAUe3QXJfyvA1T8H718SHkUb3b5q
         wdNgMN8ehAh+wljWQVzbaw/WfQ4uPeL21nx+h6p58vSzcisCH2xVdD3RblPVeTtoYUX7
         4ufDO4FUJTI7upmpLR8vv5FlV2/+81iGR+kUvcCoJrT926P8LIS+x3TF5P2N8a+/VEZp
         OP/bSigihFi14Rtq1wpsQHH/rgncxxfmeCWHzXIkOkALUfvNA+Gfel1oLwgpSuTK2YIf
         RAn6/v1VFPZgLH9CdsmhDb0GOFdfluRq+IF/ueA5c6KS9kbskJF2EawSo88naUJQL8eg
         ZVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i0orxC0f9GEHv/18++7WN43Uk702gBVzndKRdF7rXHA=;
        b=a5l7vy2smeSsoeqKw8+Ss93yWgHDUj2hcPn731+lCl2ClB3xyh9t6j+6uE/3Cq8YGy
         zv9bquvXXFWh2rCIAKLz4PI5f7pdpmrv3Donwyl+nEFyqrTLjETvBnXpwCSFxIyOHauh
         SrJ1hUcbv3yp9vXtQWuhKSFdnInkA3PjIg6pP+LcbJf912XrxnAqwwIKIAokNc7rKUZC
         x9o9Y5pA/VSpHwYCzBkOvAw8+vU07MyfIrsjkQ3MWVyPdfwdk/UftRLmdsM+lFPNFi7e
         1VkXuNPhmUGGyhO/xo62AW1mEzErdTsaujiIV5JFukkgqj06HXuqy7Mil31f93f7DZ9/
         wTIA==
X-Gm-Message-State: APjAAAVTxawG0OzBFbnE/jnKVhlrHyM9WWzB8C1CsNdQo6teIbvPgB9Z
        II7xymLyvMJgFCqKZuWbsJU=
X-Google-Smtp-Source: APXvYqzoSdPmxaFy+b36g7AsoPwnE+n6Iu7wUPBmxvMqvxdr30WB+O7t1NUu0zzE5ovMUgwYqR1dgg==
X-Received: by 2002:a0c:edc2:: with SMTP id i2mr68859024qvr.62.1578061020720;
        Fri, 03 Jan 2020 06:17:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 16sm16533935qkj.77.2020.01.03.06.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 06:17:00 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 3 Jan 2020 09:16:58 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20200103141658.GA1204556@rani.riverdale.lan>
References: <20200102155129.GA668939@rani.riverdale.lan>
 <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
 <20200102172637.GB701372@rani.riverdale.lan>
 <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
 <20200102174142.GA713602@rani.riverdale.lan>
 <CAKv+Gu-NDps2EP865v45sUbKRwSc2fwvcfLt64BKX_D=ErmvMQ@mail.gmail.com>
 <20200102181015.GA720259@rani.riverdale.lan>
 <CAKv+Gu8stpJ2YZ6sJb5WvwftNy9SDsQpxoS1uH0FV5vXQKvihA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8stpJ2YZ6sJb5WvwftNy9SDsQpxoS1uH0FV5vXQKvihA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 07:38:06PM +0100, Ard Biesheuvel wrote:
> On Thu, 2 Jan 2020 at 19:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Jan 02, 2020 at 06:48:52PM +0100, Ard Biesheuvel wrote:
> > > Currently, I am not managing to get the 64-bit compiler to emit any
> > > GOT based references for efi_is64, though, even without the attribute,
> > > so I am not sure what's going on there.
> >
> > With gcc 9, I do get R_X86_64_REX_GOTPCRELX relocations in libstub,
> > which are then eliminated by the linker -- if they weren't they would be
> > using addresses from the GOT. They turn into R_X86_64_PC32 with the
> > hidden visibility.
> 
> Indeed. I was looking at eboot.o but that gets built with -fPIE not
> -fPIC [if available].
> 
> libstub objects indeed have the R_X86_64_REX_GOTPCRELX relocations, so
> I'll add the hidden visibility to the extern declaration of efi_is64

Is there any reason not to compile the stub with -fPIE btw? Also fPIE
seems to be there even in gcc 4.1.2, the check for availability can
probably be dropped.
