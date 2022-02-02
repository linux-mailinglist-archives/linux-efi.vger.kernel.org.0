Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D75C4A6D3B
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 09:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbiBBItW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 03:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245015AbiBBItV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 03:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTjMgxqFw7q3lN61xuKdMsCU7dwv3H2LQch/NOGulyE=;
        b=EpljswTe8npkRzhFe6lmcBsGIEG++b4BDm4Bp3kVnTKiDMImZGrPgD2+zzky1wiL3Us1la
        6rm6jinDw9DkoH7xoge2qXZ/ReizZAlfdmLC8pEOLQvwrastNn3Us2h/HY6jNMC5Ox2Ixm
        UkE6gLgVCGeTNI0fe8Jm+c3l9GWqAMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-e53eU149PTiv7iptKT2yDQ-1; Wed, 02 Feb 2022 03:49:18 -0500
X-MC-Unique: e53eU149PTiv7iptKT2yDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F21D81F002;
        Wed,  2 Feb 2022 08:49:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC5E31F2F9;
        Wed,  2 Feb 2022 08:49:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 396041800397; Wed,  2 Feb 2022 09:49:09 +0100 (CET)
Date:   Wed, 2 Feb 2022 09:49:09 +0100
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
Subject: Re: [PATCH v7 5/5] docs: security: Add coco/efi_secret documentation
Message-ID: <20220202084909.ancetiuel6xysh2q@sirius.home.kraxel.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-6-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201124413.1093099-6-dovmurik@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 12:44:13PM +0000, Dov Murik wrote:
> Add documentation for the efi_secret module which allows access
> to Confidential Computing injected secrets.

Looks good, but might need updates when the paths change.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

