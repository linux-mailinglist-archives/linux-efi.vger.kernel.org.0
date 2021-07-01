Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8002F3B96BC
	for <lists+linux-efi@lfdr.de>; Thu,  1 Jul 2021 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhGATsf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Jul 2021 15:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhGATsd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 1 Jul 2021 15:48:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF76361405;
        Thu,  1 Jul 2021 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625168762;
        bh=NPkS1ghP8adWFqTQtg/FLb8BIjLGbYN/OQB5Qfuakjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLRuk6JalTWH0mDWe7EC6fEfJgk7g+FtSBLJIHt3CgATtLxj6XtPeCTq1tI3bQyrv
         cxr5ZW7XgFfP8OByZ0B3m3xBX8mb80llXmuMrmvd/xsrKFX3PS+KUb4PLbe7ixozuF
         khnSIEHvGcHyXCrzuuXrvY+NU6x0e3+QsYlrrehReV7nmaUIqeG+k4SMS07BoFPdIX
         iKwlf/Uebmy9o7NcjKDER/Zk2Xn7UzksS4vLCPs9VzPc79S8AE8zn/JzV5YjvTCuEA
         kEiaxXjNS4zH3vakx6EY5YRJzmSZSyNxtIJWbDXdDjGv9bZpw7fRe84JgjjorHHx/u
         Az/6ZOpQvvGkQ==
Date:   Thu, 1 Jul 2021 22:45:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/setup: always reserve the first 1M of RAM
Message-ID: <YN4bcMK3pX7X4AiX@kernel.org>
References: <20210601075354.5149-1-rppt@kernel.org>
 <20210601075354.5149-2-rppt@kernel.org>
 <cc655618-9e30-9377-4fcf-c967707b4b0b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc655618-9e30-9377-4fcf-c967707b4b0b@intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 01, 2021 at 10:15:29AM -0700, Dave Hansen wrote:
> On 6/1/21 12:53 AM, Mike Rapoport wrote:
> > There are BIOSes that are known to corrupt the memory under 1M, or more
> > precisely under 640K because the memory above 640K is anyway reserved for
> > the EGA/VGA frame buffer and BIOS.
> 
> Should there have been a Cc: stable@ on this?
> 
> Seems like the kind of thing we'd want backported.

The commit this patch is fixing (a799c2bd29d1) went to v5.13-rc1, so there
is no need to backport it.

-- 
Sincerely yours,
Mike.
