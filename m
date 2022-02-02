Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D824A6D02
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 09:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiBBIis (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 03:38:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236289AbiBBIis (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 03:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZeRfyP/3NDflTT3uYjL7nAay4ukmclUl6g3683qMY8=;
        b=RzuTFsTJMswo8YkNKjZQLR0jsbOWeac6GncYwv+/XHfnt3TIt/dIp/Pw2Fby2xCcdS4y0X
        o+9D66PDtpYARSJzV2yK6eZHTIAfPxFYKMf1FwMKV2y3JcT8RU5XmgWWGQvlPPPeoQGF+n
        eiEfdPJ3911luZUpU3Izo8FuHYAruAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-pzyL3YZLODSNqGuB5n4qXg-1; Wed, 02 Feb 2022 03:38:38 -0500
X-MC-Unique: pzyL3YZLODSNqGuB5n4qXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88C74184608A;
        Wed,  2 Feb 2022 08:38:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11B9462D65;
        Wed,  2 Feb 2022 08:38:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9C9DF1800397; Wed,  2 Feb 2022 09:38:22 +0100 (CET)
Date:   Wed, 2 Feb 2022 09:38:22 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] efi: Save location of EFI confidential computing
 area
Message-ID: <20220202083822.fgyamauzqco374u2@sirius.home.kraxel.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-2-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201124413.1093099-2-dovmurik@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 12:44:09PM +0000, Dov Murik wrote:
> Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
> Virtualization) allows a guest owner to inject secrets into the VMs
> memory without the host/hypervisor being able to read them.
> 
> Firmware support for secret injection is available in OVMF, which
> reserves a memory area for secret injection and includes a pointer to it
> the in EFI config table entry LINUX_EFI_COCO_SECRET_TABLE_GUID.
> 
> If EFI exposes such a table entry, uefi_init() will keep a pointer to
> the EFI config table entry in efi.coco_secret, so it can be used later
> by the kernel (specifically drivers/virt/coco/efi_secret).  It will also
> appear in the kernel log as "CocoSecret=ADDRESS"; for example:
> 
>     [    0.000000] efi: EFI v2.70 by EDK II
>     [    0.000000] efi: CocoSecret=0x7f22e680 SMBIOS=0x7f541000 ACPI=0x7f77e000 ACPI 2.0=0x7f77e014 MEMATTR=0x7ea0c018
> 
> The new functionality can be enabled with CONFIG_EFI_COCO_SECRET=y.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

