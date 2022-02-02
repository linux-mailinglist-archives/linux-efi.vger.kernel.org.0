Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC954A6D10
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 09:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiBBIlN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 03:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245034AbiBBIlM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 03:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFr35wABT1Ag+M7eB8Ldl2IgucK7WzY17RANVrytmIU=;
        b=M3VMxzHI2Rpi+ouJTSux81Abr/bynxySqIe4ACQUzZnBsNISlpdzXuR8o2EMiNGI+QzwOI
        f3m7/qwMaamzHt+A2LQd5fyfwDdOv7raYZREy6n/5gIFaspKO29h+j/qOApCUQNAtDWaUY
        fMDDowSXw5Ucp00VYxNrbl/HIA6otjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-3oBYIt5vNsyzynImwyx0gw-1; Wed, 02 Feb 2022 03:41:08 -0500
X-MC-Unique: 3oBYIt5vNsyzynImwyx0gw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA3846861;
        Wed,  2 Feb 2022 08:41:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC2BE16A5A;
        Wed,  2 Feb 2022 08:41:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 20C131800397; Wed,  2 Feb 2022 09:41:04 +0100 (CET)
Date:   Wed, 2 Feb 2022 09:41:04 +0100
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
Subject: Re: [PATCH v7 2/5] efi/libstub: Reserve confidential computing
 secret area
Message-ID: <20220202084104.zkhnclpxigct4tf6@sirius.home.kraxel.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-3-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201124413.1093099-3-dovmurik@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 12:44:10PM +0000, Dov Murik wrote:
> Some older firmware declare the confidential computing secret area as
> EFI_BOOT_SERVICES_DATA region.  Fix this up by treating this memory
> region as EFI_RESERVED_TYPE, as it should be.
> 
> If that memory region is already EFI_RESERVED_TYPE then this has no
> effect on the E820 map.

Hmm, sure we actually want merge this?  I suspect by the time this
landed in an upstream kernel "older firmware" isn't much of a problem
any more.

take care,
  Gerd

