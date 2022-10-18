Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E5603497
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 23:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJRVFW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRVFW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 17:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B17FF9C
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 14:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666127120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUAo3dL9hhBdy5lWB8FHvKsjCOg7DiowFZ/MAPIKBRo=;
        b=ZClSzD9VsyEfArG8Hmz0cofVXGioM7AywXwG57MNAPIApw9Si+Fva2CKfYRS6+vMtVvBP0
        cuPFpTv8JWZJuarJ5/K/AaIBP5IxMqHQs4QzOLNFTViTrwwIPWlQSboj2uD8j0bm/HsHc0
        DT0IBAPZ2E1/SIwOBp2ddszPhPQe31U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-s4HuxjnEOT2bgY5OaJH7oA-1; Tue, 18 Oct 2022 17:04:52 -0400
X-MC-Unique: s4HuxjnEOT2bgY5OaJH7oA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D2E93814580;
        Tue, 18 Oct 2022 21:04:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9095B2166BAD;
        Tue, 18 Oct 2022 21:04:48 +0000 (UTC)
Date:   Tue, 18 Oct 2022 17:04:47 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/16] x86_64: Improvements at compressed kernel stage
Message-ID: <20221018210447.sg3tddaujre6orgc@redhat.com>
References: <cover.1662459668.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1662459668.git.baskov@ispras.ru>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 06, 2022 at 01:41:04PM +0300, Evgeniy Baskov wrote:
> This patchset is aimed
> * to improve UEFI compatibility of compressed kernel code for x86_64
> * to setup proper memory access attributes for code and rodata sections
> * to implement W^X protection policy throughout the whole execution 
>   of compressed kernel for EFISTUB code path. 

Hi Evgeniy,

I've tested this set of patches with the Mu firmware that supports the W^X
feature and a modified bootloader to also support it, and also with an
existing firmware and the grub2 build in fedora 36.  On the firmware
without W^X support, this all works for me.  With W^X support, it works
so long as I use CONFIG_EFI_STUB_EXTRACT_DIRECT, though I still need
some changes in grub's loader.  IMO that's a big step forward.

I can't currently make it work with W^X enabled but without direct
extraction, and I'm still investigating why not, but I figured I'd give
you a heads up.

-- 
        Peter

