Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8224A7F3E
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 07:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiBCGQ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 01:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237581AbiBCGQZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 01:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643868985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qol4FKjmV5kyybqxOmO1rEWopOD7vMCwFa3iVh2RSaE=;
        b=XeJRk0BbqQUNSlwpXBLfL7Bfxxok1k89HA8z+2c07ETxde8YJRuha4wi8dppcjWWBg22CA
        zaI/Sttuim6XxC08kQ/1jpvA99qktAey3x68avTfpLL65wX6WYCWhpVmLuHLolxw0fHnIZ
        ATynz/TabZ9UNFV6ucuglVWY/77zw80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-DUscOsTDNXewyeL3p7AHiw-1; Thu, 03 Feb 2022 01:16:21 -0500
X-MC-Unique: DUscOsTDNXewyeL3p7AHiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85FCA1091DA1;
        Thu,  3 Feb 2022 06:16:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 355884BC40;
        Thu,  3 Feb 2022 06:16:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5CE6C1800605; Thu,  3 Feb 2022 07:16:15 +0100 (CET)
Date:   Thu, 3 Feb 2022 07:16:15 +0100
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
Message-ID: <20220203061615.wwembqmmpmg77iyj@sirius.home.kraxel.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-5-dovmurik@linux.ibm.com>
 <20220202084723.ushasiekb3cxami4@sirius.home.kraxel.org>
 <c7604c39-d6ca-f3b9-b1d8-fd0362216717@linux.ibm.com>
 <20220202143128.jgadmr7tzetlobt7@sirius.home.kraxel.org>
 <cb548aa2-1ac3-46e7-91e4-f57a4fd63754@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb548aa2-1ac3-46e7-91e4-f57a4fd63754@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

  Hi,

> > I think the module should fail noisily.  See above for autoload.  In
> > case the module is loaded (either manually by the admin, or because
> > efi.coco_secret != EFI_INVALID_TABLE_ADDR) and it can't actually load
> > the secrets we want know why ...
> 
> Note that the AmdSev build of OVMF always publishes
> LINUX_EFI_COCO_SECRET_TABLE_GUID in the EFI table.  Even when
> LAUNCH_SECRET was not executed.  In such cases the secret area will be
> empty.

Hmm, ok.  Why?  I assume the secret area is filled by the host and ovmf
doesn't even look at it?

> If we keep only the 'efi.coco_secret != EFI_INVALID_TABLE_ADDR' check,
> we'll get errors from efi_secret for every VM launch that doesn't
> undergo LAUNCH_SECRET.  I don't think that's good.

Well, if that is a common case the module could either print nothing or
log KERN_INFO level instead of KERN_ERROR.

> If we *do* want to check that the area starts with
> EFI_SECRET_TABLE_HEADER_GUID (like I think we should), we need all the
> checks before that, like checking that the area is big enough, and that
> all the memremap()s succeed -- before actually comparing the
> header_guid.  The checks are basically prerequisites for calling
> efi_guidcmp() safely.

It is still not fully clear to me why you want do that check twice.

take care,
  Gerd

