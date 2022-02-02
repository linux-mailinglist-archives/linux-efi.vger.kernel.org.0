Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161E34A6D1C
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 09:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbiBBIpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 03:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245135AbiBBIpX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 03:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAx4tea4gU+ph2qsMKy11PzCKAhCH3M6+a5vwHPvxF0=;
        b=NWq3wHvlOsn6V6rPMrnqSM5OjCqr871pwLqBrLWcn9+ccvazWXYG4xYUa3vIV+lMBhhIsf
        OFN4QEJudyBvQzBfzOA/IUKdjrWwy+nBVHncTs/OD2IDz2DlUF6fhouESUvkYEsp1ic8we
        NigJsGna3YY+CzKBMITpADHGZJvy0Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-Ua6dXLfSOLKQ6kelMviBtw-1; Wed, 02 Feb 2022 03:45:17 -0500
X-MC-Unique: Ua6dXLfSOLKQ6kelMviBtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2121B1898299;
        Wed,  2 Feb 2022 08:45:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9AE116A5A;
        Wed,  2 Feb 2022 08:45:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 107F51800397; Wed,  2 Feb 2022 09:45:13 +0100 (CET)
Date:   Wed, 2 Feb 2022 09:45:13 +0100
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
Subject: Re: [PATCH v7 3/5] virt: Add efi_secret module to expose
 confidential computing secrets
Message-ID: <20220202084512.2errjezf7ugrhntr@sirius.home.kraxel.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-4-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201124413.1093099-4-dovmurik@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

  Hi,

> +	s->coco_dir = NULL;
> +	s->fs_dir = NULL;
> +	memset(s->fs_files, 0, sizeof(s->fs_files));
> +
> +	dent = securityfs_create_dir("coco", NULL);
> +	if (IS_ERR(dent)) {
> +		pr_err("Error creating coco securityfs directory entry err=%ld\n", PTR_ERR(dent));
> +		return PTR_ERR(dent);
> +	}
> +	s->coco_dir = dent;
> +
> +	dent = securityfs_create_dir("efi_secret", s->coco_dir);
> +	if (IS_ERR(dent)) {
> +		pr_err("Error creating efi_secret securityfs directory entry err=%ld\n",
> +		       PTR_ERR(dent));
> +		return PTR_ERR(dent);
> +	}
> +	d_inode(dent)->i_op = &efi_secret_dir_inode_operations;
> +	s->fs_dir = dent;

Why have two levels of subdirectories here?  Do we expect more users for
the coco/ directory?

See also the naming discussion in the cover letter sub-thread.

take care,
  Gerd

