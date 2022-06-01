Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45A353A93C
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbiFAOdU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239881AbiFAOdT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 10:33:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172361400E
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 07:33:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z13so2192207ljn.11
        for <linux-efi@vger.kernel.org>; Wed, 01 Jun 2022 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCSZBRlbrl+wVf2rxucv5zcNIA855Ca5kZwzalOYvb0=;
        b=VVLJD0NAQILvJHfkfQdPPcZQYLPIvuU383slFb0XqyUhc32YzHWh5sxJyXBVFHQYJy
         J92H5Fw4LbWBvdWB1iS6I3yvfJJWHZw8bqQDOC6b44r7JyavcgRc2mBCUj6eeznjSuDk
         nyIxkcatYhb+zHY7xIfeQHW+2ukP9E+RdX9pYQ/ykkIXmvJS9ayfu/0ACvyDq232jvYe
         SeMxgVf6YbK4Dc0/HecM5JX7ykfd2b36y1SR6Q6Szo5lJNS5UckHGL7PzNDLGZF4Hv2p
         M18Yixf8P1Cs2Qz2tWaphg/Rz3oQ7A+VQVQtbOGBofEaAAzm/2V2dk8Dql19ozH6RH8U
         GKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCSZBRlbrl+wVf2rxucv5zcNIA855Ca5kZwzalOYvb0=;
        b=5+pzLgnoHT7TUkpVi4UoH0+qRxHDUWbkbOJ/EFCb2df8MMXwqAzD1WZnXrw60sV2BB
         t1Hn7UMlWnRJOF03aWE0I2GYP8G6ncE1lQ7doYfw/eYuoblco44t62EiXZVRdbomr+2F
         yVGgXHH4D9u/zryVRU06Zh4vxEGRCsnz21W0sLPGW2zIdRFBpfNyOSxMsul5zPMaLG5H
         DurnIogD1+NNWiEUATDs3hu0IFHpJYRckPTc1usT0u0UGA8D+UwXO/J5o0ERfUJk7XI0
         FKl6ywG/N0R+ugpSmlEymbpxLqZhpyPSq5dz4alJ5kfWn0gWNExhIaIgE9xqkQx77uOP
         hPew==
X-Gm-Message-State: AOAM532aTfa/qOkgOIqPMphvADmabqdo5UF83ryYNt8V2zbYutiq7AVy
        CUi4BjA6V5ZEW88rdEroTSQO2w==
X-Google-Smtp-Source: ABdhPJxwZgIPL7egdv7c+WP6CgrkdcITk/oDwU0+MJ0tE1U4J5QLdAPVS/TIaa7FdZYS+ZxQQIntVA==
X-Received: by 2002:a2e:920f:0:b0:255:4f66:956 with SMTP id k15-20020a2e920f000000b002554f660956mr9356579ljg.191.1654093996359;
        Wed, 01 Jun 2022 07:33:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o8-20020a056512230800b00478feae4f24sm388181lfu.268.2022.06.01.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:33:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0A26E109789; Wed,  1 Jun 2022 17:35:15 +0300 (+03)
Date:   Wed, 1 Jun 2022 17:35:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 03/15] efi/x86: Get full memory map in allocate_e820()
Message-ID: <20220601143515.iavmtysdchirbtel@box.shutemov.name>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-4-kirill.shutemov@linux.intel.com>
 <b9a0eb0a-ce27-5306-a12f-79d196445254@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a0eb0a-ce27-5306-a12f-79d196445254@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 01, 2022 at 11:00:23AM +0200, David Hildenbrand wrote:
> On 17.05.22 17:34, Kirill A. Shutemov wrote:
> > Currently allocate_e820() only interested in the size of map and size of
> > memory descriptor to determine how many e820 entries the kernel needs.
> > 
> > UEFI Specification version 2.9 introduces a new memory type --
> > unaccepted memory. To track unaccepted memory kernel needs to allocate
> > a bitmap. The size of the bitmap is dependent on the maximum physical
> > address present in the system. A full memory map is required to find
> > the maximum address.
> > 
> > Modify allocate_e820() to get a full memory map.
> 
> Usually we use max_pfn, if we want to know the maximum pfn that's
> present in the system (well, IIRC, excluding hotunplug).
> 
> How exactly will this (different?) maximum from UEFI for the bitmap
> interact with
> 
> max_pfn = e820__end_of_ram_pfn();
> 
> from e820 in existing code
> 
> ?

I'm not sure I understand the question.

On EFI system, E820 is constructed based on EFI memory map and size of
bitmap calculated based of EFI memmap will always be enough to address all
memory. e820__end_of_ram_pfn() can be smaller than what what we calculate
as size of memory here, if kernel reserve very top of the memory, but it
will never be larger.

Later during the boot we use e820__end_of_ram_pfn() to infer size of
bitmap and it is safe.

-- 
 Kirill A. Shutemov
