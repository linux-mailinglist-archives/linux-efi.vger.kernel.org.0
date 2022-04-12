Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831004FDC1A
	for <lists+linux-efi@lfdr.de>; Tue, 12 Apr 2022 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347900AbiDLKO2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Apr 2022 06:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387625AbiDLJIe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Apr 2022 05:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BFBBDB
        for <linux-efi@vger.kernel.org>; Tue, 12 Apr 2022 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649751522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HjEpVaoQD5ARkUa//p08UmNnQm2oDsvimQB15pvFtYY=;
        b=gNoBLSp+7HRBC90tecSmv1Dq9akYyFfG1uEwx3dX3afBtzL+HaUAfdVeVFpJ2TI7tKa0NZ
        pCZiOwJVu0l3G/UoocE8/a64h0rxRbIuNONOeK1bKTIYQyuVbwdTtZtoJN++EazXYEnA3W
        uajXR1KabEBoTU1srZoliLYu542Waqw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-vAENIk4yO7uvbZbZG9Cblw-1; Tue, 12 Apr 2022 04:18:40 -0400
X-MC-Unique: vAENIk4yO7uvbZbZG9Cblw-1
Received: by mail-wr1-f71.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so3798626wrg.20
        for <linux-efi@vger.kernel.org>; Tue, 12 Apr 2022 01:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HjEpVaoQD5ARkUa//p08UmNnQm2oDsvimQB15pvFtYY=;
        b=Kb9c9Xp2xeVjUBqihk23y2ScWJQ6gIolJ4p8lYOodWl0ISsY8Wd8QlyoiMKwJLuAoM
         3V1bhPfVPddjhBVrtKaDWQcp2O7n9CYGqxn3pHfPfyA/jcQebAh5rXcxYZj2QB4KO+4U
         f+HSEGAhWKkQK9BXtsbacQQDJ1v3NbAo7glbaC3fNBAS8+NbPxK+IqPg33EMO8q9zgAC
         z/PUxcysYsO/LzGIQIPcy8ds2C7cdjv+t02zOFZzodxi/m9dHxmXtIlmTW9PQqWQpxI0
         2gVuyGuojITW0+JX+4sE/PHu4md1bI12UgOHf4MYVlcDu5E4InCmBBgxJGf2T7xi/z3x
         08xA==
X-Gm-Message-State: AOAM5312jM/sGYDJnojheJC1RcT8GwduFGcBs38JdcAzvPj5Q9XQhAjH
        8gYzsXdeOzHYYy3TjNPJCBQ5OCBSL9JjDyJTlHA8JcU3K+0APwQFgwuOpmjLlfm9qE00cXRzDm4
        2JrJ9OzIE/l5fs6QmQQsX
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id o12-20020a5d47cc000000b002041c9d2157mr27253334wrc.294.1649751519280;
        Tue, 12 Apr 2022 01:18:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtAJ2/UNdxCVTBdsyo9WuJJCk5rWPxBJRneEzkaBvsDA/8B/+o2maXYXbvtqtOlUtJh6R1kg==
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id o12-20020a5d47cc000000b002041c9d2157mr27253303wrc.294.1649751519001;
        Tue, 12 Apr 2022 01:18:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc40d000000b0038e9edf5e73sm1959421wmi.3.2022.04.12.01.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:18:38 -0700 (PDT)
Message-ID: <b3a221fb-2382-5b19-4fbd-031629d641fd@redhat.com>
Date:   Tue, 12 Apr 2022 10:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCHv4 8/8] mm/vmstat: Add counter for memory accepting
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-9-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220405234343.74045-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 06.04.22 01:43, Kirill A. Shutemov wrote:
> The counter increased every time kernel accepts a memory region.
> 
> The counter allows to see if memory acceptation is still ongoing and
> contributes to memory allocation latency.
> 

Does it? See my other mail, can't we have the counter essentially not
changing for a long time but still some unaccepted pages sitting at the
tail of the freelists that will only get allocated+accepted under real
memory pressure?

-- 
Thanks,

David / dhildenb

