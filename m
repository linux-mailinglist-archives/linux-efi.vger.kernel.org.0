Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43EC612E9BF
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 19:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgABSKT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 13:10:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37308 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgABSKS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 13:10:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so35236734qtk.4
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 10:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WWcH4/7sry9WUFtHJqusPNxo12okI1+y3DAmxoC8oXs=;
        b=MEXYZrv8jijjGETUTGNahjg5y1Xiry0D+ZvT3+0NR8tEf86pY2kMv289+LNzTqgXM/
         HgWSREll+qA16/dUtHEFkz5D+fSQYaPpzOWNi+4Jjdv3smPu8J9uuqOyQ0nLgS7DkrZ0
         BP6BoBf/7Xo7wPLqMTVhpip6NLKpjEE0PSZeVhRVCLAbRqgFGLRWYu0/vz7Nh3xs9zlm
         FDzP+6nQ6T7ROgNVS90Zd0b2qHNivDZgnVezxVxU2Wiawje8dIH0TPCjJgJ1On7M6ZAy
         ak1uHjBKZCgaLe+kd6FkYv7SZG+t6Q2/JuCwPlKcNm5yr4XVXfJnv+jlQQEVCZza4YAi
         kREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWcH4/7sry9WUFtHJqusPNxo12okI1+y3DAmxoC8oXs=;
        b=S3VqPVCvahs0c4reRE7V9FvLX08nkeRQECiJ2QT5/czjiymryScctAOTertc2zzPP0
         1jbVsrHIpi5u6iIELK2P5OLGI7AH+mBI3Lwd3FR+TQgbwhmcZfvid+h35GUWK0mlMylp
         jLqWBYvK0eOQzB3N/3GGVz+ckHtYpeeCPEGCa3oJr78z4NEcf5KkBpii/2RLbIqUU9bk
         MQc9vbxh+gsaOYs96Y8LJxXjsrLoBS/VYnERe095lSMCnl/o2hiNkhcrRfiI9WFiO035
         p5cKATRYGK/V37wB/BdS/mKER+M74bTaFqthdThfjlv1gGi4C9QnFX6SKsIqo5kDlfos
         MUYA==
X-Gm-Message-State: APjAAAU6Y8TcTEEgXWrUakueOJ3SGEIeYdhCR7BYMWxWPnHuKrapRo1V
        bDhaWwq/gfLLgMBEyo76wK0=
X-Google-Smtp-Source: APXvYqz1ftM8AY3llHJewdasEen6Q8ANZ5jDGuwXqioUYrZA05oARGGY2jXnLxtJ4yg4vrGKsnh5CA==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr61469640qte.327.1577988617772;
        Thu, 02 Jan 2020 10:10:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c24sm14854050qtk.40.2020.01.02.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 10:10:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 2 Jan 2020 13:10:15 -0500
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
Message-ID: <20200102181015.GA720259@rani.riverdale.lan>
References: <20200102140653.GA626673@rani.riverdale.lan>
 <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan>
 <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
 <20200102172637.GB701372@rani.riverdale.lan>
 <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
 <20200102174142.GA713602@rani.riverdale.lan>
 <CAKv+Gu-NDps2EP865v45sUbKRwSc2fwvcfLt64BKX_D=ErmvMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-NDps2EP865v45sUbKRwSc2fwvcfLt64BKX_D=ErmvMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 06:48:52PM +0100, Ard Biesheuvel wrote:
> Currently, I am not managing to get the 64-bit compiler to emit any
> GOT based references for efi_is64, though, even without the attribute,
> so I am not sure what's going on there.

With gcc 9, I do get R_X86_64_REX_GOTPCRELX relocations in libstub,
which are then eliminated by the linker -- if they weren't they would be
using addresses from the GOT. They turn into R_X86_64_PC32 with the
hidden visibility.
