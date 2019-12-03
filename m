Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464BE10FEED
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 14:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLCNi1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 08:38:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47266 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbfLCNi0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 08:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575380305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j86gFYchvxCAdw1aMDtjnplAIlCiAIyuvE/UGPPey4g=;
        b=AdStPFuPNMypw9a8IQhhKh59sE0K4fagB7fO9A3aP21qgHesI0j5lmIjkcks34bJjjPwHI
        oMbIPuIY6MredRc87kvAWfTR0Nr3q8vf6EmVeZ+1e+D4xxFm1OSDVbPuVavw2VEfKxsJ+2
        6+tqvVeQyT94j694sraIAUltLSXtkiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-0wNpRvzAOSKhHDhgWywmsA-1; Tue, 03 Dec 2019 08:38:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 252CE802B63;
        Tue,  3 Dec 2019 13:38:21 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-183.ams2.redhat.com [10.36.117.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94CDB5C3FD;
        Tue,  3 Dec 2019 13:38:19 +0000 (UTC)
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com>
 <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <9c58f2d2-5712-0972-6ea7-092500f37cf9@redhat.com>
Date:   Tue, 3 Dec 2019 14:38:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0wNpRvzAOSKhHDhgWywmsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/03/19 12:54, Ard Biesheuvel wrote:
> (+ Laszlo)
> 
> On Tue, 3 Dec 2019 at 00:43, Matthew Garrett <mjg59@google.com> wrote:
>>
>> On Mon, Dec 2, 2019 at 4:40 PM Matthew Garrett
>> <matthewgarrett@google.com> wrote:
>>>
>>> Add an option to disable the busmaster bit in the control register on
>>> all PCI bridges before calling ExitBootServices() and passing control to
>>> the runtime kernel. System firmware may configure the IOMMU to prevent
>>> malicious PCI devices from being able to attack the OS via DMA. However,
>>> since firmware can't guarantee that the OS is IOMMU-aware, it will tear
>>> down IOMMU configuration when ExitBootServices() is called. This leaves
>>> a window between where a hostile device could still cause damage before
>>> Linux configures the IOMMU again.

(1) This vaguely reminds me of
<https://bugzilla.tianocore.org/show_bug.cgi?id=675>.


(2) I'm not 100% convinced this threat model -- I hope I'm using the
right term -- is useful. A PCI device will likely not "itself" set up
DMA (maliciously or not) without a matching driver. The driver will
likely come from the device too (option ROM). The driver will program
the device to do DMA. So, whatever the system firwmare does wrt. the
IOMMU for OS protection purposes, the device driver from the option ROM
can undo.

Is this a scenario where we trust the device driver that comes from the
device's ROM BAR (let's say after the driver passes Secure Boot
verification and after we measure it into the TPM), but don't trust the
silicon jammed in the motherboard that presents the driver?


(3) I never understood why the default behavior (or rather, "only"
behavior) for system firmware wrt. the IOMMU at EBS was "whitelist
everything". Why not "blacklist everything"?

I understand the compat perspective, but the OS should at least be able
to request such a full blackout through OsIndications or whatever. (With
the SEV IOMMU driver in OVMF, that's what we do -- we set everything to
encrypted.)

>> I don't know enough about ARM to know if this makes sense there as well. Anyone?
> 
> There is no reason this shouldn't apply to ARM, but disabling bus
> mastering like that before the drivers themselves get a chance to do
> so is likely to cause trouble. Network devices or storage controllers
> that are still running and have live descriptor rings in DMA memory
> shouldn't get the rug pulled from under their feet like that by
> blindly disabling the BM attribute on all root ports before their
> drivers have had the opportunity to do this cleanly.

I agree.

> 
> One trick we implemented in EDK2 for memory encryption was to do the
> following (Laszlo, mind correcting me here if I am remembering this
> wrong?)
> - create an event X
> - register an AtExitBootServices event that signals event X in its handler
> - in the handler of event X, iterate over all PPBs to clear the bus
> master attribute
> - for bonus points, do the same for the PCIe devices themselves,
> because root ports are known to exist that entirely ignore the BM
> attribute
> 
> This way, event X should get handled after all the drivers' EBS event
> handlers have been called.

Yes. Please see the commit message and the code comments in the
following edk2 commit:

https://github.com/tianocore/edk2/commit/7aee391fa3d0

I'm unsure how portable it is to platforms that are not derived from edk2.

Thanks!
Laszlo

