Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1166BC50
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 11:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjAPK6K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 05:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjAPK5p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 05:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E014EBF
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673866617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMSn7PTMEvVVrQFt74Q3u3R9ASe6C2Dbwlt9UzpnyIA=;
        b=WEfzlfBpqzyiwaWHp8HOtZF7CTKRLSnw5g1D/FeXxmzMY1OvqdA2sNQCuvIdmQJ3iYsnCV
        w9kAK+AbLQEujxS8k7HSXni6IVf+yrA5N9UkwJmFLQPOrF18SlM1mAUfGAoDreJLc7iVGS
        FFU5B7vXshkc1aKd+RdD31xczlQnDXI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-Xw_dsNCgOiuaYGOnxBKnEQ-1; Mon, 16 Jan 2023 05:56:51 -0500
X-MC-Unique: Xw_dsNCgOiuaYGOnxBKnEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 600553814944;
        Mon, 16 Jan 2023 10:56:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEAE651FF;
        Mon, 16 Jan 2023 10:56:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6ABEB18017F5; Mon, 16 Jan 2023 11:56:48 +0100 (CET)
Date:   Mon, 16 Jan 2023 11:56:48 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 14, 2023 at 01:20:24AM +0300, Kirill A. Shutemov wrote:
> On Fri, Jan 13, 2023 at 09:29:26PM +0000, Dionna Glaze wrote:
> > This patch depends on Kirill A. Shutemov's series
> > 
> > [PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory
> > 
> > The UEFI v2.9 specification includes a new memory type to be used in
> > environments where the OS must accept memory that is provided from its
> > host. Before the introduction of this memory type, all memory was
> > accepted eagerly in the firmware. In order for the firmware to safely
> > stop accepting memory on the OS's behalf, the OS must affirmatively
> > indicate support to the firmware.
> 
> I think it is a bad idea.
> 
> This approach breaks use case with a bootloader between BIOS and OS.
> As the bootloader does ExitBootServices() it has to make the call on
> behalf of OS when it has no idea if the OS supports unaccepted.

Nothing breaks, it'll error on the safe side.  If the protocol callback
is not called the firmware will simply accept all memory.  The guest OS
will only see unaccepted memory if it explicitly asked for it (assuming
the firmware wants know to support both cases, of course the firmware
could also enforce the one or the other and just not offer the
protocol).

> Note that kexec is such use-case: original kernel has to make a
> decision on whether it is okay to leave some memory unaccepted for the
> new kernel.

Not sure what you are trying to tell.  The kexec case doesn't go
through the efi stub anyway.

> And we add this protocol to address very temporary problem: once
> unaccepted memory support get upstream it is just a dead weight.

Maybe, maybe not.  unaccepted memory support has a Kconfig switch after
all.  If we figure in 3-5 years that all distros have enabled it anyway
we can drop it again.  For the transition period it will surely be
useful.

take care,
  Gerd

