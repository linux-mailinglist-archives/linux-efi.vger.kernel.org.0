Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445936BAB9C
	for <lists+linux-efi@lfdr.de>; Wed, 15 Mar 2023 10:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjCOJHU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Mar 2023 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjCOJGx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Mar 2023 05:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744F65461
        for <linux-efi@vger.kernel.org>; Wed, 15 Mar 2023 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678871103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Mqz4aBhLPd8yTktiuvKtk7CpkmrnJC3LuH6Fk/wXuQ=;
        b=AbVhlGN9/uAn4+wneW1czDUW/xZxVgEKUFjiSN16x8TpbbJEDIqXQtxk/z7RB9cEQmwC68
        2dy3qi/HWtBaiZH0eirSc/O2RogLgh14uBwIz5A6OaGyUGYlWmONLGOGLmtXtn+1gAIo9F
        iJiRornZykHHvg3tW9TI2GriiNKL1Bk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-y8ENYj6HMtqbxEJlqJBR-A-1; Wed, 15 Mar 2023 05:05:00 -0400
X-MC-Unique: y8ENYj6HMtqbxEJlqJBR-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EF6B801206;
        Wed, 15 Mar 2023 09:04:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFF601410F1B;
        Wed, 15 Mar 2023 09:04:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5C88A1800393; Wed, 15 Mar 2023 10:04:57 +0100 (CET)
Date:   Wed, 15 Mar 2023 10:04:57 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 00/27] x86_64: Improvements at compressed kernel stage
Message-ID: <20230315090457.6spo4f4v2l4qwdu2@sirius.home.kraxel.org>
References: <cover.1678785672.git.baskov@ispras.ru>
 <d575db7f-bad3-477e-a501-19d2d84527cd@app.fastmail.com>
 <ea1b6e36-c434-49e9-bede-b4bd2b41868d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1b6e36-c434-49e9-bede-b4bd2b41868d@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> And *this* seems to be the actual issue:
> 
> https://github.com/rhboot/shim/pull/459/commits/825d99361b4aaa16144392dc6cea43e24c8472ae
> 
> I assume that MS required this change as a condition for signing, but what do I know?

Your guess is correct.  UEFI world is moving to being stricter, for
example set page permissions according to the allocation type (RW for
data, RX for code).

Microsoft raised the bar for PE binaries when it comes to secure boot
signing as part of that effort.  Being a valid PE binary according to
the PE spec is not good enough, some additional constrains like sections
not overlapping and sections with different load flags not sharing pages
(so setting strict page permissions is actually possible) are required
now.  Stuff which is standard since years elsewhere.

>  Anyway, the rules appear to be that the PE sections must not be both W and X at the same size.

That too.

> But I still think we should keep the demand-faulting code as a
> fallback, even if it's hardcoded as RW, and just log the fault mode
> and address.  We certainly shouldn't be *executing* code that wasn't
> identity mapped.  Unless that code is boot services and we're creating
> the boot services mappings!

Agree.

> For that matter, how confident are we that there aren't crappy boot
> services implementations out there that require that we fix up page
> faults? After all, it's not like EFI implementations, especially early
> ones, are any good.

I don't expect much problems here.  Early EFI implementations don't
bother setting page permissions and just identity-map everything using
rwx huge pages, or run with paging turned off (hello ia32).

But playing safe (and keep demand-faulting just in case) is a good idea
nevertheless.

take care,
  Gerd

