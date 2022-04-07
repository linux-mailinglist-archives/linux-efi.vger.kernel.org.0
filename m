Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F044F7D17
	for <lists+linux-efi@lfdr.de>; Thu,  7 Apr 2022 12:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbiDGKjR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Apr 2022 06:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244945AbiDGKiK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Apr 2022 06:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FC9719058C
        for <linux-efi@vger.kernel.org>; Thu,  7 Apr 2022 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649327770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tmb94Vnr/m1iiTombsEjR+CsqwafFX61UIDruzVV9I=;
        b=A1ayr8DrsDphmbjhCwAYaGbnZRlnMd8dlzm1DefV4UuJCR7zgQoh1crxft+TPAJFhsKcom
        TtmMKayK6LWSbpgsUhU8Eyr+3HX9ohkM1ZdlNXkTxgApTWk6rwll4kl0d+eD69seXj5ZBw
        coGKgANGzUmcFUrhvFLXSaMUIMA+6zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-m1pDVn1JM7SgfIYbB3R6ug-1; Thu, 07 Apr 2022 06:36:06 -0400
X-MC-Unique: m1pDVn1JM7SgfIYbB3R6ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24CE11066680;
        Thu,  7 Apr 2022 10:36:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74C117B7C;
        Thu,  7 Apr 2022 10:36:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0721218000B3; Thu,  7 Apr 2022 12:36:03 +0200 (CEST)
Date:   Thu, 7 Apr 2022 12:36:02 +0200
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
Subject: Re: [PATCH v9 2/4] virt: Add efi_secret module to expose
 confidential computing secrets
Message-ID: <20220407103602.5hblcyz4zzocjgcw@sirius.home.kraxel.org>
References: <20220331215607.3182232-1-dovmurik@linux.ibm.com>
 <20220331215607.3182232-3-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331215607.3182232-3-dovmurik@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 31, 2022 at 09:56:05PM +0000, Dov Murik wrote:
> The new efi_secret module exposes the confidential computing (coco)
> EFI secret area via securityfs interface.
> 
> When the module is loaded (and securityfs is mounted, typically under
> /sys/kernel/security), a "secrets/coco" directory is created in
> securityfs.  In it, a file is created for each secret entry.  The name
> of each such file is the GUID of the secret entry, and its content is
> the secret data.
> 
> This allows applications running in a confidential computing setting to
> read secrets provided by the guest owner via a secure secret injection
> mechanism (such as AMD SEV's LAUNCH_SECRET command).
> 
> Removing (unlinking) files in the "secrets/coco" directory will zero out
> the secret in memory, and remove the filesystem entry.  If the module is
> removed and loaded again, that secret will not appear in the filesystem.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

