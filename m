Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D153AD85
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 21:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiFATsS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFATsO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 15:48:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703DE1CF14A;
        Wed,  1 Jun 2022 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Wkd+qK1A5XBz5WZBnQIdi6DW33K+oMosCMS+4sZy/cs=; b=AGVDXW8/nu43WRDD1uEPuOrwI9
        QhL8aaFxX8SyDpgfEbqrvquPDhrASGgMBINTb5sv+WrH7Xh1sDd+n5Agn78lUIaSslsWWcG+aDLRX
        58d0g5oAaZy8W/AHowNwVTzGv9KWJrSjhiPqUKaiwj2IbyUal9XsN2TUZY0LiW9ZmMGJNHUdgT6CL
        SBccDuSyXo4Bk96TwW7Le6bBfgHn12WoBvV6qqqhr1tCnkFiJ927xRMQDxKQlDSjMjbksTP3TWZk/
        rTsCrcf9n+FtYzXV3GDBCUG2yI+aicquUJWjcO5Ph84LXWBe+qfoMoObnSkPW0dybPx/KvY6mBwVF
        MfoIpimw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwU71-006YNd-JO; Wed, 01 Jun 2022 19:34:35 +0000
Message-ID: <fa512bb1-bf3d-fbf3-69da-1796653ec5bf@infradead.org>
Date:   Wed, 1 Jun 2022 12:34:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     "Xu, Min M" <min.m.xu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Gao, Jiaqi" <jiaqi.gao@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
 <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic>
 <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
 <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com>
 <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com>
 <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi--

On 6/1/22 09:20, Dionna Amalie Glaze wrote:
> The memory accounting in Linux is probably the issue. Both times I ran
> the test were from a freshly booted VM. The test parses the output of
> $(free -k) to determine the amount of free memory it should allocate
> and write/read from, with a given stride of pages to skip before
> touching the next page.
> 
> We grab the third column of numbers from the Mem output that looks like this
> 
>                total        used        free      shared  buff/cache   available
> Mem:        65856604     4128688    48558952       11208    13168964    60942928
> Swap:        1953788      118124     1835664
> 
> So my workstation has 48558952 free bytes. We take that, give it to
> memtouch to allocate that much anonymous memory rounded down to the
> nearest MB with mmap and randomly read/write the buffer.
> 
> For an 8GB machine, the UEFI will have the initial 0-0xA000 memory and
> 0x10_0000 to 0xC00_0000 (beginning of mmio hole) prevalidated. The
> next 5GB is classified as the UEFI v2.9 memory type
> EFI_RESOURCE_MEMORY_UNACCEPTED, 0x1_4000_000 to 0x2_0000_0000.
> The Linux e820 map should see that range as unaccepted rather than
> EFI_CONVENTIONAL_MEMORY (i.e., EDK2's EFI_RESOURCE_SYSTEM_MEMORY), but
> I think it needs to be accounted as free conventional memory.
> 
> So when I see 2044MB free vs 7089MB free in my VMs, the two are
> roughly 5GB different.

Please see/read/use
  https://people.kernel.org/tglx/notes-about-netiquette

-- 
~Randy
