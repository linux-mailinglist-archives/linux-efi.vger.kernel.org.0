Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F41148B6
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 22:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfLEVay (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 16:30:54 -0500
Received: from heinz.dinsnail.net ([81.169.187.250]:42578 "EHLO
        heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfLEVay (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 16:30:54 -0500
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
        by heinz.dinsnail.net (8.15.2/8.15.2) with ESMTP id xB5LUEC0010903;
        Thu, 5 Dec 2019 22:30:14 +0100
Received: from eldalonde.UUCP (uucp@localhost)
        by heinz.dinsnail.net (8.15.2/8.15.2/Submit) with bsmtp id xB5LUDNb010898;
        Thu, 5 Dec 2019 22:30:13 +0100
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1])
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2) with ESMTP id xB5LFWAK010648;
        Thu, 5 Dec 2019 22:15:32 +0100
Received: (from michael@localhost)
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2/Submit) id xB5LFWDY010647;
        Thu, 5 Dec 2019 22:15:32 +0100
Date:   Thu, 5 Dec 2019 22:15:32 +0100
From:   Michael Weiser <michael@weiser.dinsnail.net>
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191205211532.GA10177@weiser.dinsnail.net>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
 <20191204101412.GD114697@gmail.com>
 <20191205105545.GA6710@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205105545.GA6710@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-dinsnail-net-MailScanner-Information: Please contact the ISP for more information
X-dinsnail-net-MailScanner-ID: xB5LUEC0010903
X-dinsnail-net-MailScanner: Found to be clean
X-dinsnail-net-MailScanner-From: michael@weiser.dinsnail.net
X-Spam-Status: No
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 05, 2019 at 06:55:45PM +0800, Dave Young wrote:

> >    esrt: Unsupported ESRT version 2904149718861218184.
> > 
> >  The ESRT memory stays in EFI boot services data, and it was reserved
> >  in kernel via efi_mem_reserve().  The initial purpose of the reservation
> >  is to reuse the EFI boot services data across kexec reboot. For example
> >  the BGRT image data and some ESRT memory like Michael reported.
> > 
> >  But although the memory is reserved it is not updated in the X86 E820 table,
> >  and kexec_file_load() iterates system RAM in the IO resource list to find places
> >  for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> >  initramfs overwrote the ESRT memory and then the failure happened.
> > 
> >  Since kexec_file_load() depends on the E820 table being updated, just fix this
> >  by updating the reserved EFI boot services memory as reserved type in E820.
> Thanks for the amending, also thank all for the review and test.

Same from me, particularly everyone's patience with my haphazard
guesswork around an area I clearly know nothing about. :)
-- 
Thanks,
Michael
