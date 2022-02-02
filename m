Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50B24A7324
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 15:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbiBBObk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 09:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344952AbiBBObk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 09:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643812299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MyaJSjL0Dz4PWQLKWTTGsW9XoK3E6CFP4+bGWUvW21Q=;
        b=BljXGuv+HB2tCEZiXn3Tuyghocf7fD7Ayw0F+aU0mlWKiNbN29Zr3nfnVHQtQzfVEpprYa
        +ZxB3y4eG3T74FeF1vdbR7KVdOPnRMXi0WL9WliLGrkLLwPgTtzE+OP0thBHB9UjbcSfHB
        h8uBHMqfybuMX3d+1CNC3dxSPB0lEOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-zZTGoK3OOuqJAf2vIECu4Q-1; Wed, 02 Feb 2022 09:31:36 -0500
X-MC-Unique: zZTGoK3OOuqJAf2vIECu4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BA44801B26;
        Wed,  2 Feb 2022 14:31:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAB1E57F2D;
        Wed,  2 Feb 2022 14:31:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 69AE51800397; Wed,  2 Feb 2022 15:31:28 +0100 (CET)
Date:   Wed, 2 Feb 2022 15:31:28 +0100
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
Subject: Re: [PATCH v7 4/5] efi: Load efi_secret module if EFI secret area is
 populated
Message-ID: <20220202143128.jgadmr7tzetlobt7@sirius.home.kraxel.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-5-dovmurik@linux.ibm.com>
 <20220202084723.ushasiekb3cxami4@sirius.home.kraxel.org>
 <c7604c39-d6ca-f3b9-b1d8-fd0362216717@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7604c39-d6ca-f3b9-b1d8-fd0362216717@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 01:08:43PM +0200, Dov Murik wrote:
> 
> 
> On 02/02/2022 10:47, Gerd Hoffmann wrote:
> > On Tue, Feb 01, 2022 at 12:44:12PM +0000, Dov Murik wrote:
> >> If the efi_secret module is built, register a late_initcall in the EFI
> >> driver which checks whether the EFI secret area is available and
> >> populated, and then requests to load the efi_secret module.
> > 
> >> +	area = memremap(efi.coco_secret, sizeof(*area), MEMREMAP_WB);
> >> +	if (!area) {
> >> +		pr_err("Failed to map confidential computing secret area descriptor\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +	if (!area->base_pa || area->size < sizeof(*header_guid))
> >> +		goto unmap_desc;
> >> +
> >> +	header_guid = (void __force *)ioremap_encrypted(area->base_pa, sizeof(*header_guid));
> >> +	if (!header_guid) {
> >> +		pr_err("Failed to map secret area\n");
> >> +		ret = -ENOMEM;
> >> +		goto unmap_desc;
> >> +	}
> >> +	if (efi_guidcmp(*header_guid, EFI_SECRET_TABLE_HEADER_GUID))
> >> +		goto unmap_encrypted;
> > 
> > Why these sanity checks are here and not in the efi_secret module?
> 
> The same checks indeed appear in the efi_secret module (see in patch 3:
> efi_secret_map_area() and the beginning of efi_secret_securityfs_setup()).
> 
> However, in the efi_secret module, the checks are noisy, because they
> expect the secret area to be populated.  For example:
> 
> +	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
> +		pr_err("Secret area address is not available\n");
> +		return -EINVAL;
> +	}

Note I explicitly excluded that check ;)

Checking whenever efi.coco_secret looks valid and only try load
efi_secret if that is the case (and otherwise stay silent) makes
perfect sense.  The other checks should be dropped IMHO.

> Another approach could be to just try to load the module anyway, and
> the module will fail (silently? noisily?) if there's no designated
> secret area or it's not populated.  I feel that will be harder to
> understand what's going on.

I think the module should fail noisily.  See above for autoload.  In
case the module is loaded (either manually by the admin, or because
efi.coco_secret != EFI_INVALID_TABLE_ADDR) and it can't actually load
the secrets we want know why ...

take care,
  Gerd

