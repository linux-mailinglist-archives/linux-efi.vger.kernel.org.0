Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D224E6710
	for <lists+linux-efi@lfdr.de>; Thu, 24 Mar 2022 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346574AbiCXQex (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Mar 2022 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243623AbiCXQev (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Mar 2022 12:34:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC66394;
        Thu, 24 Mar 2022 09:33:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A80BC210DE;
        Thu, 24 Mar 2022 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648139596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dbhz+ybJt4D/7rvN1XiATlgmvR6Aewf7ESgiyrrZ7Yw=;
        b=kyFS+QmrdikOIAyu85pf34IM7NTSPRzvhyEohUDKptM40CJb4HZV8vkaUKwC+5GBuuI/u4
        BdbnHKjZVlx5+V/WOQNlec7FfLgJ26UMTE3LgMRaFVxvrnKgAAKEdWcZGpeBa9B94HPCx2
        gDLj/FR61nkJYUBKAuMTVPVZCXUiohU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648139596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dbhz+ybJt4D/7rvN1XiATlgmvR6Aewf7ESgiyrrZ7Yw=;
        b=7/mvJ+Xgdou9td6wINIMvnPyezFvoELByPAGONf6IWHYhUjJRbtWHeIEI77pdLj6NAF/dw
        8r/NnEt3LcHFjhBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9897C132E9;
        Thu, 24 Mar 2022 16:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O6czJUydPGI2QwAAMHmgww
        (envelope-from <bp@suse.de>); Thu, 24 Mar 2022 16:33:16 +0000
Date:   Thu, 24 Mar 2022 17:33:12 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
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
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YjydSNnG6EJ1KWx0@zn.tnic>
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 28, 2022 at 11:42:50AM +0000, Dov Murik wrote:
> Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
> Virtualization) allows guest owners to inject secrets into the VMs
> memory without the host/hypervisor being able to read them.  In SEV,
> secret injection is performed early in the VM launch process, before the
> guest starts running.
> 
> OVMF already reserves designated area for secret injection (in its
> AmdSev package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the
> Sev Secret area using a configuration table" [1]), but the secrets were
> not available in the guest kernel.
> 
> The patch series keeps the address of the EFI-provided memory for
> injected secrets, and exposes the secrets to userspace via securityfs
> using a new efi_secret kernel module.  The module is autoloaded (by the
> EFI driver) if the secret area is populated.

Right, so this thing.

Tom and I were talking about SEV* guest debugging today and I believe
there might be another use case for this: SEV-ES guests cannot find out
from an attestation report - like SNP guests can - whether they're being
debugged or not so it would be very helpful if the fact that a -ES guest
is being debugged, could be supplied through such a secrets blob.

Because then, when I'm singlestepping the guest with gdb over the
gdbstub, the guest could determine based on those guest-owner previously
injected secrets whether it should allow debugging or not.

And this is where your set comes in.

However, I'm wondering if - instead of defining your own secrets structs
etc - you could use the SNP confidential computing blob machinery the
SNP set is adding. In particular:

https://lore.kernel.org/all/20220307213356.2797205-30-brijesh.singh@amd.com/

And you're adding another GUID but maybe you could simply use the SNP
thing called EFI_CC_BLOB_GUID and mimick that layout.

That should unify things more. And then guest kernel code could query
the blob also for debugging policy and so on.

Thoughts, opinions?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
