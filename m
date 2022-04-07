Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5AF4F7D1F
	for <lists+linux-efi@lfdr.de>; Thu,  7 Apr 2022 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244508AbiDGKkA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Apr 2022 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbiDGKjs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Apr 2022 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2A861C2A00
        for <linux-efi@vger.kernel.org>; Thu,  7 Apr 2022 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649327863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OiNxFjZsmsvUmZcyzfwdmxD4iCK54gZ12CfFIhQmEvM=;
        b=gm+7N4XkHulQlXJO6XK7SYFmOY2VgMDUg0VMKZDqodcE+UwnZ4XnReWp5ugYemR7hW1hIt
        UdtmtDONRR/oYrPBvayxhnt48JbYeMdY8AsZm7fsx9ClmVEea/2gG+ngoxWBF2SukzbEuw
        IY8OsNH/1H7C2cQ8AoQU7zYSrnHob44=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-lxF3ruGvN4Cog91D9aXOqw-1; Thu, 07 Apr 2022 06:37:39 -0400
X-MC-Unique: lxF3ruGvN4Cog91D9aXOqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DF38100BAA7;
        Thu,  7 Apr 2022 10:37:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 170671121314;
        Thu,  7 Apr 2022 10:37:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C3BBB18000B3; Thu,  7 Apr 2022 12:37:17 +0200 (CEST)
Date:   Thu, 7 Apr 2022 12:37:17 +0200
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
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/4] efi: Register efi_secret platform device if EFI
 secret area is declared
Message-ID: <20220407103717.s2t72bzv2th6k6f2@sirius.home.kraxel.org>
References: <20220331215607.3182232-1-dovmurik@linux.ibm.com>
 <20220331215607.3182232-4-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331215607.3182232-4-dovmurik@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 31, 2022 at 09:56:06PM +0000, Dov Murik wrote:
> During efi initialization, check if coco_secret is defined in the EFI
> configuration table; in such case, register platform device
> "efi_secret".  This allows udev to automatically load the efi_secret
> module (platform driver), which in turn will populate the
> <securityfs>/secrets/coco directory in guests into which secrets were
> injected.
> 
> Note that a declared address of an EFI secret area doesn't mean that
> secrets where indeed injected to that area; if the secret area is not
> populated, the driver will not load (but the platform device will still
> be registered).
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

