Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987ED4A839B
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 13:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbiBCMLb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 07:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344660AbiBCMLb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 07:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643890290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1GA7e6azQ71Q/Pk7PvNK6H2CwoTwPPyoDKVlcVN5cKI=;
        b=gkqLq/GTYg6BwfSm+5WurRNZXa6jNeKP9BdN4K/GawHZgUZL8ikfXnTOdmyv1Zge6zI7jb
        GnRy3AGd1VZUTCa59AJUvnbgbjxJxX3KR+kW75bSE5qj0U3MAaB+sZ9fp3O948dAkCS5hm
        U6Iq9pglNeonwtlkdmgsOaG6DyZcthk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-n9p20QooOgCo9jBaiAHZ_w-1; Thu, 03 Feb 2022 07:11:26 -0500
X-MC-Unique: n9p20QooOgCo9jBaiAHZ_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 049A02F44;
        Thu,  3 Feb 2022 12:11:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F35456F16B;
        Thu,  3 Feb 2022 12:11:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 620E518000B2; Thu,  3 Feb 2022 13:11:17 +0100 (CET)
Date:   Thu, 3 Feb 2022 13:11:17 +0100
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
Message-ID: <20220203121117.aedtaxspnm5mbqhj@sirius.home.kraxel.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-5-dovmurik@linux.ibm.com>
 <20220202084723.ushasiekb3cxami4@sirius.home.kraxel.org>
 <c7604c39-d6ca-f3b9-b1d8-fd0362216717@linux.ibm.com>
 <20220202143128.jgadmr7tzetlobt7@sirius.home.kraxel.org>
 <cb548aa2-1ac3-46e7-91e4-f57a4fd63754@linux.ibm.com>
 <20220203061615.wwembqmmpmg77iyj@sirius.home.kraxel.org>
 <815ba487-a6c1-0daa-aead-a7f3a52df2a1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815ba487-a6c1-0daa-aead-a7f3a52df2a1@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

  Hi,

> >> If we keep only the 'efi.coco_secret != EFI_INVALID_TABLE_ADDR' check,
> >> we'll get errors from efi_secret for every VM launch that doesn't
> >> undergo LAUNCH_SECRET.  I don't think that's good.
> > 
> > Well, if that is a common case the module could either print nothing or
> > log KERN_INFO level instead of KERN_ERROR.
> 
> What if the user doesn't inject a secret and doesn't include the
> efi_secret module at all in the initrd?  request_module("efi_secret")
> will fail.
> 
> I can ignore the error code of request_module("efi_secret") but that
> feels bad.

Looking at the error code returned by request_module should help to
figure what happened (module load failed / no secret present / something
else).

But, yes, module load errors are harmless in case there is no secret
present in the first place.  Hmm, tricky.  I don't see a way to solve
that without duplicating the checks.

I withdraw my objections.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

