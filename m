Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF6753B53F
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jun 2022 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiFBIks (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jun 2022 04:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFBIkr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jun 2022 04:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF04E29ADC6
        for <linux-efi@vger.kernel.org>; Thu,  2 Jun 2022 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654159245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9X9eKlzEclLa6MvLNYAdFd2zQQAwQquxfSZzdJAnY0=;
        b=NmRuwFX1htFMSdfCudNRzhtwon778XRcjckkivexexrBkLfoYX1sFw8F4MJrPjrt+4e9sa
        WtXDpdr3KUaapuQ7c8C05blPc96LR07kfIpctylKad8MROVdTJ1JG1yzQuf6V7pawKQbWK
        MRsjcu22PaMR7HlHsyaemJPL1cGpWfI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-PEbzhDbCPdiG7UiuI35Wpw-1; Thu, 02 Jun 2022 04:40:04 -0400
X-MC-Unique: PEbzhDbCPdiG7UiuI35Wpw-1
Received: by mail-wm1-f70.google.com with SMTP id n18-20020a05600c3b9200b00397335edc7dso4802483wms.7
        for <linux-efi@vger.kernel.org>; Thu, 02 Jun 2022 01:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=J9X9eKlzEclLa6MvLNYAdFd2zQQAwQquxfSZzdJAnY0=;
        b=qFS9nTc0D/Wwau8VPkokhzamflO3s94LkpX0MZrPDk42p+gwq7XLvp144LCckez9IC
         WDT78bAOgfE0yUbDOZ5SJNWTJjywYDrHpw3A44/03SOSAz0d0ar0Vz2UUeoc6I8/aCD+
         R6hoP5BDRML9nt/ombP08LhXOV52mrrA53BwrlkUEDmh0R/Q+2IO0pXbC0HQSQIWnf+e
         iPmhZlU9CB8fzcRWJjCoZdDqNq8nF56mlKzc6cnK6FU2/dqjzWv5Io81YRhyL6MA2ImW
         /gEoeiQ/NWZpvYkKcvb111YgNILWcNPwgvF4rUJe/TInHHIPcKYK671SXhLN3u9MeYae
         eNmA==
X-Gm-Message-State: AOAM531YyVpslp1g1ftVII5E3TtqoDyb2J7xipRdma6qa8cSWLz/71CG
        6CXV44+w+yHflBqTn1Yv/9Mm4Fx5FVJsuhcD4H+BOhZveuBreIEJKTabEO58yfzc4qNGShnWMbQ
        +XRTZpNVGwouvJLsI2ekr
X-Received: by 2002:adf:f6d2:0:b0:211:f0bf:3d14 with SMTP id y18-20020adff6d2000000b00211f0bf3d14mr2763521wrp.264.1654159203378;
        Thu, 02 Jun 2022 01:40:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfIfFeYpd+hweqJ+/V1YU5ayupuojpWaT3H2UqQkV92iVE0trL+kBR715ZoiwRRgjTHCszLw==
X-Received: by 2002:adf:f6d2:0:b0:211:f0bf:3d14 with SMTP id y18-20020adff6d2000000b00211f0bf3d14mr2763500wrp.264.1654159203090;
        Thu, 02 Jun 2022 01:40:03 -0700 (PDT)
Received: from [192.168.178.20] (p57a1a7d6.dip0.t-ipconnect.de. [87.161.167.214])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d5045000000b0020d07d90b71sm3675589wrt.66.2022.06.02.01.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:40:02 -0700 (PDT)
Message-ID: <a678504c-3468-12e5-b51d-5670bdf165e5@redhat.com>
Date:   Thu, 2 Jun 2022 10:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv6 10/15] x86/mm: Report unaccepted memory in /proc/meminfo
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-11-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220517153444.11195-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 17.05.22 17:34, Kirill A. Shutemov wrote:
> Track amount of unaccepted memory and report it in /proc/meminfo.

I feel like instead of doing this arch specific tracking here, we should
simply report the total number of unaccepted (base) pages in the buddy.

When the system boots up, the number will rise as unaccepted memory gets
exposed to the buddy. But especially once user space is up and running,
that number should only go down.

Once it hits zero, there is no unaccepted memory left in the buddy and
there won't be any performance surprises anymote -- and AFAIKT, that's
what we really care about.

-- 
Thanks,

David / dhildenb

