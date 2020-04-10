Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B31A45C4
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJLm7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 07:42:59 -0400
Received: from www17.your-server.de ([213.133.104.17]:59768 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgDJLm7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 07:42:59 -0400
X-Greylist: delayed 1007 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2020 07:42:58 EDT
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www17.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <thomas@m3y3r.de>)
        id 1jMrnU-00033v-Fi; Fri, 10 Apr 2020 13:26:08 +0200
Received: from [2a02:908:4c22:ec00:8ad5:993:4cda:a89f] (helo=localhost.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <thomas@m3y3r.de>)
        id 1jMrnU-0008wV-2k; Fri, 10 Apr 2020 13:26:08 +0200
Date:   Fri, 10 Apr 2020 13:26:05 +0200
From:   Thomas Meyer <thomas@m3y3r.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Sergey Shatunov <me@prok.pw>, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200410112605.GA3344@localhost.localdomain>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406180614.429454-1-nivedita@alum.mit.edu>
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25777/Thu Apr  9 13:52:18 2020)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 06, 2020 at 02:06:13PM -0400, Arvind Sankar wrote:

Hi,

I did write an email to x86@kernel.org, which sadly seems to have no
mailing list archive, I wonder if my problem has anything to do with the
patches you are discussing here:

I found this reply, which contains my original email in my inbox:

Subject: Kernel v5.5 doesn't boot on my x86 laptop

Hi,

I'm using an old MacBookPro1,1 to run Fedora 30 (the last one to support
x86) and a upstream up-to-date kernel, currently 5.4.16.

I'm using sd-boot to boot into an EFI-enabled kernel which contains
an embedded initram cpio image (because loading the image from kernel's
EFI stub doesn't seem to work for some unknown reason, I tried to debug
this but my early debugging foo is too weak).

Kernel 5.4.x works correctly with this setup (but resuming from disk
seems to have broken in 5.4.x or maybe even earlier - when resuming from
disk I get all kind of funky OOPSes/errors, but that's another story, hopefully
5.5.x was fixed in this regards).

So I did have a look at the commits under arch/x86/boot and "x86/boot:
Introduce setup_indirect" (b3c72fc9a78e74161f9d05ef7191706060628f8c) did
talk about "bump setup_header version in arch/x86/boot/header.S", so I
did revert above commit and I was finally able to boot into v5.5 kernel!

So either sd-boot also needs an upgrade or this commit does break
something.
Any help is welcome, don't hesitate to get in contact with me if you
have any questions.

mfg
thomas
 
