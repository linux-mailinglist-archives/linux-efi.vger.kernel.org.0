Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2466DB4E
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 11:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjAQKk3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 05:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbjAQKjf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 05:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E930E86
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 02:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673951700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QQOt8ySyPNfsebwY1js22piNE2vG1l6hynTNM9Lu89A=;
        b=UYUfkZBH3EcJvH0PSXhf/NU1uYBYzIyjOejXOyV/e3ecxzgEWIgumuEzA7Uu+4oO/7OkdB
        LiGneWOLWNqlgaumlYL3me6A0mHhLxnZsFSIftG5Yh3P0bDHEWXxy9alESoLSkULFeWTkm
        qsGLg8XOuLJjMSg4jj9j+F0pJWp/wCE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-R2m6b25aP3W36F_H3VIq-g-1; Tue, 17 Jan 2023 05:34:54 -0500
X-MC-Unique: R2m6b25aP3W36F_H3VIq-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E213E811E6E;
        Tue, 17 Jan 2023 10:34:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F9981121315;
        Tue, 17 Jan 2023 10:34:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0DCDC1800097; Tue, 17 Jan 2023 11:34:51 +0100 (CET)
Date:   Tue, 17 Jan 2023 11:34:51 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230117103451.74k6eddipikhml3y@sirius.home.kraxel.org>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <def9b0b5-b880-be99-fa95-b05d76a91824@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def9b0b5-b880-be99-fa95-b05d76a91824@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

  Hi,

> In any case, the firmware side of things didn't seem like _that_ much
> code.  So, I'm not protesting *that* strongly.  But, I also don't
> believe for a second that this is going to be removed in 3-5 years.

If things are going roughly as I expect them to go (both tdx support and
unaccepted memory support land upstream this year; distros enable it by
default) we should be able to drop this when the 6.1-lts kernel goes
EOL.  First in edk2, later in linux too.

take care,
  Gerd

