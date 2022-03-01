Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1484C8B80
	for <lists+linux-efi@lfdr.de>; Tue,  1 Mar 2022 13:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiCAMZX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Mar 2022 07:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCAMZW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Mar 2022 07:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE9478BF6E
        for <linux-efi@vger.kernel.org>; Tue,  1 Mar 2022 04:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646137481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=px8h7rOi4DLdnxTseE4yd2HQ+w2dXi8TPIQasAQ9aI0=;
        b=dYLd+zJIKZOaIdU6A5dcX9wWbMrdvDhHTrDb4hVKYlvIK9mO3nUFQDLiidGDtkbAXOAEO7
        w6V/pnTsUm2xwdGdfwMa/5gP+wXbvkFf9DQEYg5R41H9ljWjqML6vwwAXOWqA6QXfWb4BI
        8co7NChr92x6nIVSqdQIt+9YFOSljnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-YRBarv4rOMm5-u5ymqgweQ-1; Tue, 01 Mar 2022 07:24:37 -0500
X-MC-Unique: YRBarv4rOMm5-u5ymqgweQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 851865200;
        Tue,  1 Mar 2022 12:24:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.195.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EC8C84945;
        Tue,  1 Mar 2022 12:24:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B993D180039D; Tue,  1 Mar 2022 13:24:31 +0100 (CET)
Date:   Tue, 1 Mar 2022 13:24:31 +0100
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
Subject: Re: [PATCH v8 2/4] virt: Add efi_secret module to expose
 confidential computing secrets
Message-ID: <20220301122431.xcsuneftshiibvst@sirius.home.kraxel.org>
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <20220228114254.1099945-3-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228114254.1099945-3-dovmurik@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 28, 2022 at 11:42:52AM +0000, Dov Murik wrote:
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

