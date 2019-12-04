Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C48112356
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 08:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLDHLq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 02:11:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726679AbfLDHLp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 02:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575443504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3GIPUfE5I/ZyJJRgqWyUDcz6F8Tn8l5oMVwt7sXiPo=;
        b=EYkrsiJ2gPNCRrqnmh6zt8P7DtfyQajaUpPbEDyofmvBp7PN85hlt7c95yOss8krXt3oLO
        h/wNwaLxstrN1FM+DPU72fYgouUrKm1F8jzlw/vrIJwdM3zqmtn46fTpYYeEEjDX6XMyuv
        fqighRxYd+NFiSDGBec1EPCewSPy15U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-7Dzj02e6PQOVam7-eHRalg-1; Wed, 04 Dec 2019 02:11:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F13C418A8CA1;
        Wed,  4 Dec 2019 07:11:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-154.ams2.redhat.com [10.36.116.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2870860C85;
        Wed,  4 Dec 2019 07:11:37 +0000 (UTC)
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com>
 <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
 <CACdnJusMeC+G3wq_oDGTYi1CBMWDiuq4NdANTBmhNBTDu5zCug@mail.gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <41cecdd8-f411-00c4-be82-be5d4d13fcb1@redhat.com>
Date:   Wed, 4 Dec 2019 08:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACdnJusMeC+G3wq_oDGTYi1CBMWDiuq4NdANTBmhNBTDu5zCug@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7Dzj02e6PQOVam7-eHRalg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/03/19 20:40, Matthew Garrett wrote:
> On Tue, Dec 3, 2019 at 3:54 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
>> There is no reason this shouldn't apply to ARM, but disabling bus
>> mastering like that before the drivers themselves get a chance to do
>> so is likely to cause trouble. Network devices or storage controllers
>> that are still running and have live descriptor rings in DMA memory
>> shouldn't get the rug pulled from under their feet like that by
>> blindly disabling the BM attribute on all root ports before their
>> drivers have had the opportunity to do this cleanly.
> 
> Yes, whether this causes problems is going to be influenced by the
> behaviour of the hardware on the system. That's why I'm not defaulting
> it to being enabled :)
> 
>> One trick we implemented in EDK2 for memory encryption was to do the
>> following (Laszlo, mind correcting me here if I am remembering this
>> wrong?)
>> - create an event X
>> - register an AtExitBootServices event that signals event X in its handler
>> - in the handler of event X, iterate over all PPBs to clear the bus
>> master attribute
>> - for bonus points, do the same for the PCIe devices themselves,
>> because root ports are known to exist that entirely ignore the BM
>> attribute
>>
>> This way, event X should get handled after all the drivers' EBS event
>> handlers have been called.
> 
> Can we guarantee that this happens before IOMMU state teardown?

In OVMF, the handler of "event X" is in the IOMMU driver itself, so it's
the IOMMU driver that takes care of blacklisting everything *after*
other drivers had a chance to clean up.

But in this case, we'd have to insert the PPB clearing *before* the
(platform's) IOMMU driver's EBS handler (because the latter is going to
deny, not permit, everything); and we can't modify the IOMMU driver.

I guess we could install an EBS handler with TPL_NOTIFY (PciIo usage
appears permitted at TPL_NOTIFY, from "Table 27. TPL Restrictions"). But:
- if the IOMMU driver's EBS handler is also to be enqueued at
TPL_NOTIFY, then the order will be unspecified
- if a PCI driver sets up an EBS handler at TPL_CALLBACK, then in our
handler we could shut down a PPB in front of a device bound by that
driver too early.

Handling dependencies between event notification functions is a
never-ending struggle in UEFI, AFAICT.

> I don't think there's a benefit to clearing the bit on endpoint devices,
> if they're malicious they're just going to turn it back on anyway.
> 

Thanks
Laszlo

