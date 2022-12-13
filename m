Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537E064BBBF
	for <lists+linux-efi@lfdr.de>; Tue, 13 Dec 2022 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiLMSPR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Dec 2022 13:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbiLMSOr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Dec 2022 13:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F21248FE
        for <linux-efi@vger.kernel.org>; Tue, 13 Dec 2022 10:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670955228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSZsQt2b+00I9NkxFr1DqCxFQqOr+fjPaGhCqsEly6E=;
        b=WfB4CjBZOB6+f+wsk6nioJbXaxbqn+lxbafGu78sxwkMd1fYJpH2eYAUB88NY/58iKbn23
        Egwpdpcm1GFKtZ4BV8+Lr0jNs3WqmQDDNKEKCvPUXdibXOPoum8scsVzBc2ioyS137VHsp
        7uF4iwuY/H2FShpaL5zH0K9pT1aa5s4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-C6I4TzwDNDuSersUHDqtIg-1; Tue, 13 Dec 2022 13:13:41 -0500
X-MC-Unique: C6I4TzwDNDuSersUHDqtIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9410101A588;
        Tue, 13 Dec 2022 18:13:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AB9051FF;
        Tue, 13 Dec 2022 18:13:40 +0000 (UTC)
Date:   Tue, 13 Dec 2022 13:13:37 -0500
From:   Peter Jones <pjones@redhat.com>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 00/24] x86_64: Improvements at compressed kernel stage
Message-ID: <20221213181336.fjyxagxkjtq3jchl@redhat.com>
References: <cover.1668958803.git.baskov@ispras.ru>
 <20221213180317.qoy2l3mcpjparocq@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221213180317.qoy2l3mcpjparocq@redhat.com>
User-Agent: NeoMutt/20180716
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

On Tue, Dec 13, 2022 at 01:03:17PM -0500, Peter Jones wrote:
> On Tue, Nov 22, 2022 at 02:12:09PM +0300, Evgeniy Baskov wrote:
> > This patchset is aimed
> > * to improve UEFI compatibility of compressed kernel code for x86_64
> > * to setup proper memory access attributes for code and rodata sections
> > * to implement W^X protection policy throughout the whole execution 
> >   of compressed kernel for EFISTUB code path. 
> 
> Hi Evgeniy,
> 
> I've tested this patch set on hardware and QEMU+MU firmware, and it
> works for me with a couple of minor issues:
> 
> - on one machine that has the DXE protocol but not the EFI one, we get
>   an error because the firmware doesn't support EFI_MEMORY_RP
> - on QEMU I'm seeing the size of "(unsigned long)_head - image_base"
>   wind up as 0, which leads to an EFI_INVALID_PARAMETER on the
>   clear_memory_attributes() call.
> 
> In both cases the system winds up working, but with unnecessary console
> output.

I just realized I've overstated here - I haven't actually hit the first
problem on x86, only on ARM, where we don't currently use this code.  I
discovered it in grub, and checked your patch set to see if you had the
same issue I did.  That said, "in both cases the system winds up
working" is probably still true - in that the edk2 code supports
EFI_MEMORY_RP on x86 but not ARM, so x86 won't hit the issue when using
DXE unless someone cooks up another implementation.  Nevertheless I
believe the patch to fix it is correct and should be applied.

Thanks!

-- 
        Peter

