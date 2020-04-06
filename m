Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E634519EEC3
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 02:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgDFABB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 5 Apr 2020 20:01:01 -0400
Received: from fallback12.mail.ru ([94.100.179.29]:46780 "EHLO
        fallback12.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgDFABB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 5 Apr 2020 20:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=+KbMK29ZT//E9SHitadTUiyxzqlP/0/hbxXj33EV400=;
        b=HJBWkyHIFPfbRH5Dt7DvYru+7ICM+O7sbrZjL5YHjzpx2P523AcWdumPJFI3wKeJHVKOajddHiXpA8T4fAFagbPEb8Z30oaZya6oCvx77tbW4d93BX5hREI0prgDyJDeHfqud3TCrfC3hLZZ6LrDI8nmwtOj9ojLnPeGxfzuEPM=;
Received: from [10.161.64.53] (port=47330 helo=smtp45.i.mail.ru)
        by fallback12.m.smailru.net with esmtp (envelope-from <me@prok.pw>)
        id 1jLFCC-0004c6-TB; Mon, 06 Apr 2020 03:00:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=+KbMK29ZT//E9SHitadTUiyxzqlP/0/hbxXj33EV400=;
        b=HJBWkyHIFPfbRH5Dt7DvYru+7ICM+O7sbrZjL5YHjzpx2P523AcWdumPJFI3wKeJHVKOajddHiXpA8T4fAFagbPEb8Z30oaZya6oCvx77tbW4d93BX5hREI0prgDyJDeHfqud3TCrfC3hLZZ6LrDI8nmwtOj9ojLnPeGxfzuEPM=;
Received: by smtp45.i.mail.ru with esmtpa (envelope-from <me@prok.pw>)
        id 1jLFBz-0000LH-0A; Mon, 06 Apr 2020 03:00:44 +0300
Message-ID: <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
From:   Sergey Shatunov <me@prok.pw>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        linux-efi@vger.kernel.org
Date:   Mon, 06 Apr 2020 07:00:39 +0700
In-Reply-To: <20200405231845.GA3095309@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
         <20200405154245.11972-1-me@prok.pw>
         <20200405231845.GA3095309@rani.riverdale.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-7564579A: B8F34718100C35BD
X-77F55803: 0A44E481635329DB0E1AA8A03B392317D32E5E48865217365060145B739F5F5C37D2C72149323728F688BCB05C26794D64D80AAD42192768407EC83892A14282A717FCED1365A4B59525BA8E2B2C40BE
X-7FA49CB5: 0D63561A33F958A54AE798525227D406AC6237357C51EF584BEFFA12B7773D298941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224979A692957AEF9EBE76E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8BE3F710C1C8B542CF3AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C360781E301B93023135872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSrqfUrc6JdFWbRFuIOw5Q1i
X-Mailru-Sender: C70B145DBB19DC3370B3FB291950C1B51DF7D989C85C045CF3B3C80E0EC4B0E77962F9E9328436E18BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 669901E4625912A97F9F52485CB584D7271FD7DF62800FDC4FDA42786C758E5644D14FAD8B0A7E49E8B94918EE1A0A8284873159AE7BD3C6
X-7FA49CB5: 0D63561A33F958A5F5E58AAAA6346AFE85FD72E8A4C480771C438537F267035D8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224979A692957AEF9EBE76E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8BE3F710C1C8B542CF3AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C360781E301B93023135872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSqLAZGOJJVRLZzUdJfQ/bjz
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C900521F65ACE11A97E3D0B57720138EF7FA944D14FAD8B0A7E4984876E3DC5E244DF8BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: Ok
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2020-04-05 at 19:18 -0400, Arvind Sankar wrote:
> I'm not familiar with systemd-boot: when you say systemd-boot stub,
> is
> that something different from the kernel's EFI_STUB option? Or is it
> just a kernel with EFI_STUB enabled and with builtin initramfs +
> builtin
> cmdline?
Basicaly systemd-boot stub is efi application with packed EFI_STUB-
enabled kernel, initrd and cmdline into single file. Source can be
found here: 
https://github.com/systemd/systemd/blob/master/src/boot/efi/stub.c

It doesn't do anything unusual, just extracting data from sections and
calling efi handover.

Final image created by objcopy'ing precompiled stub and adding sections with that stuff:

    objcopy \
        --add-section .osrel=os_release --change-section-vma
'.osrel=0x20000' \
        --add-section .cmdline=cmdline --change-section-vma
'.cmdline=0x30000' \
        --add-section .linux=vmlinuz --change-section-vma
'.linux=0x2000000' \
        --add-section .initrd=initrd --change-section-vma
'.initrd=0x3000000' \
        /usr/lib/systemd/boot/efi/linuxx64.efi.stub output.efi

> The first error message you mention should be from systemd-boot after
> the kernel exits with an EFI_BUFFER_TOO_SMALL error status. The
> second
> one -- is that 'exit_boot() failed' rather than 'exit_efi() failed'?
> I
> can't find the latter string in the tree.
Yeah, probably it's exit_boot()

> Can you also specify a commit tag that is broken + works with this
> patch
> reverted, just to make sure we're looking at the same code?
I'm using latest master branch from Torvalds tree, so latest commit
(for now it's a10c9c710f9ecea87b9f4bbb837467893b4bef01) broken, but
with 3ee372ccce4d4e7c610748d0583979d3ed3a0cf4 reverted works.

Not sure
what I should specify as broken except the
3ee372ccce4d4e7c610748d0583979d3ed3a0cf4 itself.
But as I told 'Buffer
Too Small' changed to 'exit_boot() failed' couple times during
bisecting (it was closely around that commit, probably in commits about
.eh_frame section), but I don't remember exactly commits when this
happened. I could do one more bisecting with more details about each
step if you wish.

