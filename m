Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98785506828
	for <lists+linux-efi@lfdr.de>; Tue, 19 Apr 2022 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiDSKCQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Apr 2022 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbiDSKCM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Apr 2022 06:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C68E22B28
        for <linux-efi@vger.kernel.org>; Tue, 19 Apr 2022 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650362369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UN1vIPrDlDYMNnHKmnDciOJ2SfD6u8L7e5xq2ukbYrQ=;
        b=bvPkEuxOU00mmJ2szka9LlV+VTgXgJjGvkn2hhM4VCtm+dWi/UMcHbhSqkFiIf6PsZGlS2
        +6l+U6OT9/G++3oqLKwW58//jmXjltV7BrO+RxqmC0dVK1CIyNUJuYpeMNN36KO7WofYGO
        F010A0g1RHlgYQScVdxl+0KH325Fz50=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-2QkbeRvuOAGsp5STnWqj9A-1; Tue, 19 Apr 2022 05:59:28 -0400
X-MC-Unique: 2QkbeRvuOAGsp5STnWqj9A-1
Received: by mail-ed1-f71.google.com with SMTP id cz22-20020a0564021cb600b0041d7e11fbfeso10711601edb.18
        for <linux-efi@vger.kernel.org>; Tue, 19 Apr 2022 02:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=UN1vIPrDlDYMNnHKmnDciOJ2SfD6u8L7e5xq2ukbYrQ=;
        b=QX/m022rmL6lKb/mh8tkiUIdR9Q4IxbKDxYUJnYIQTn5bs0SEQ7GoDIr+t4R9VC7Q1
         R1JY0uiW4+dZe2BddOi+S0sJgaNICsZsUsIJGsE4dTPxexjN03nxHHUUPs1YEkjU29gi
         jZo9L0QDf9cfzHEPfd8TV5syG0+Pg56MAeDkI/bacrQT3sq87Yjsc4IDKTy54o4O7iys
         pLzu2xGA1mDsAabeQ7ATyOEx3+VtDanMWHrm+m4qxxtZtkPJhyRKqGTbCmvQZngmSFP8
         uy3Dnr3QiggSoBScgiz9dYUAJ0SW5dwSMz0EIyD1PF2Rs4WcVnY/Z5bcgkKUdajnBRpF
         d5WQ==
X-Gm-Message-State: AOAM532YYqJYkm0ftYlrDRQtZfshPZyrE4XyS9R7OPn5z+SkV98wI22I
        DWIp5hyt07lE1FcNg+qI151+5oNuhfrTQXz1tvYkE4GgQlG9bxSOgk7hdd8z9ap5fWrtS6/y25T
        RfY6ANr5RIN1SyQ1VltMu
X-Received: by 2002:a50:cc9e:0:b0:41d:7123:d3ba with SMTP id q30-20020a50cc9e000000b0041d7123d3bamr16609573edi.296.1650362367075;
        Tue, 19 Apr 2022 02:59:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVvAeLuhhiE03oc3LVAMyOA6sJOPQzFvmr9Ic8ljheVIvAvwF/eWkql2K0s6VNOSXbUdHhjg==
X-Received: by 2002:a50:cc9e:0:b0:41d:7123:d3ba with SMTP id q30-20020a50cc9e000000b0041d7123d3bamr16609554edi.296.1650362366841;
        Tue, 19 Apr 2022 02:59:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm5490550ejc.24.2022.04.19.02.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:59:26 -0700 (PDT)
Message-ID: <ef669ff4-24a1-4401-40d6-693d5dbe3402@redhat.com>
Date:   Tue, 19 Apr 2022 11:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 7/9] mm: Calc the right pfn if page size is not 4K
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net
Cc:     ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zyccr.com, dvhart@infradead.org, andy@infradead.org,
        rppt@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        jroedel@suse.de, songmuchun@bytedance.com, macro@orcam.me.uk,
        frederic@kernel.org, W_Armin@gmx.de, john.garry@huawei.com,
        seanjc@google.com, tsbogend@alpha.franken.de,
        anshuman.khandual@arm.com, chenhuacai@kernel.org,
        gpiccoli@igalia.com, mark.rutland@arm.com,
        wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
References: <20220414101314.1250667-1-mawupeng1@huawei.com>
 <20220414101314.1250667-8-mawupeng1@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220414101314.1250667-8-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 14.04.22 12:13, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Previous 0x100000 is used to check the 4G limit in
> find_zone_movable_pfns_for_nodes(). This is right in x86 because
> the page size can only be 4K. But 16K and 64K are available in
> arm64. So replace it with PHYS_PFN(SZ_4G).
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6e5b4488a0c5..570d0ebf98df 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7870,7 +7870,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  
>  			usable_startpfn = memblock_region_memory_base_pfn(r);
>  
> -			if (usable_startpfn < 0x100000) {
> +			if (usable_startpfn < PHYS_PFN(SZ_4G)) {
>  				mem_below_4gb_not_mirrored = true;
>  				continue;
>  			}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

