Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90972507333
	for <lists+linux-efi@lfdr.de>; Tue, 19 Apr 2022 18:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354722AbiDSQlo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Apr 2022 12:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiDSQlj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Apr 2022 12:41:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF471409E;
        Tue, 19 Apr 2022 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386336; x=1681922336;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to;
  bh=/sjp7gFP/WNMm0rhzedY8jJRt5eNgyrw8SaiEPlBRkw=;
  b=U4sD6VP4rs6MsMNXzjHQVOX+f0q4g/MO2CpF/Cj4rfoxHbJukqZnbcru
   5Yjfl4MeMDm/gbHdBPc5ubHrJjuNpmcIwVkJfLTD1uR5XtBCW+XtRratq
   eexSLLv8JGySwOZgPU/Go1ynJID+Dplr31v5PaUqSN2zKm9sg2R9+55za
   IAmmFZlUp+jPvV35CUXBvDfvCaEfS4cUiTDHmhZjkUrsP/18yYgbzOH2K
   /6vsMte6k2bunQTPkYLrzxAsO+gN37t4/e0IW2fpOjV0xIZUhOE74lA8n
   1v/SAdN8LMteElfLY8x0OZZ20Y7xHYS6Hy16CMgAwHLDqr6/R71s5FUhg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324253344"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="324253344"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:38:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="530465027"
Received: from sazizi-mobl2.amr.corp.intel.com (HELO [10.212.98.167]) ([10.212.98.167])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:38:54 -0700
Content-Type: multipart/mixed; boundary="------------eWVLiKb8hW4mlc5kPUXDDJhx"
Message-ID: <79df6889-aa74-2a86-7565-be882623ddad@intel.com>
Date:   Tue, 19 Apr 2022 09:38:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
 <Yl2UHOQ4iZJ29k0q@zn.tnic>
 <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
 <Yl3RmPhdZieSr8W2@zn.tnic>
 <20220418235015.mnujtlmmlyin7y6m@box.shutemov.name>
 <Yl5nSSC4HpSWqfY7@zn.tnic>
 <20220419153002.ffh2ybdl7x2mm7zw@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 3/8] efi/x86: Implement support for unaccepted memory
In-Reply-To: <20220419153002.ffh2ybdl7x2mm7zw@box.shutemov.name>
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a multi-part message in MIME format.
--------------eWVLiKb8hW4mlc5kPUXDDJhx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/22 08:30, Kirill A. Shutemov wrote:
>> I think the stuff coming from the linux/ namespace you can simply copy
>> into a header in compressed/, like I've done with efi.h.
> Hm. Dave was worried about having copies of _find_next_bit() and
> __bitmap_*() inside compressed/.
> 
> How do we rectify code duplication and making decompresser self-contained?
> Do we care about multiple copies of the same code in the kernel?
> Do we care about keeping them in sync?

Would it be feasible to have the common code defined as a 'static
inline' in a header that both the main kernel and the decompressor could
include?  Something like the attached patch.

I'd much rather duplicate something like this:

int strncasecmp(const char *s1, const char *s2, size_t len)
{
        return __lib_strncasecmp(s1, s1, len);
}

in the decompressor versus a real full implementation.
--------------eWVLiKb8hW4mlc5kPUXDDJhx
Content-Type: text/x-patch; charset=UTF-8; name="lib-header.patch"
Content-Disposition: attachment; filename="lib-header.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IGQ5NGZhNjg0MmIyNTgwOTk1ODkwM2ZkZDMzZDQ5OGJiNjIyNjk1YTUKQXV0aG9y
OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPgpEYXRlOiAgIFR1
ZSBBcHIgMTkgMDk6MzE6MDcgMjAyMiAtMDcwMAoKICAgIGZvbwogICAgCiAgICBiYXIxCgpk
aWZmIC0tZ2l0IGEvbGliL3N0cmluZy1pbnRlcm5hbC5oIGIvbGliL3N0cmluZy1pbnRlcm5h
bC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uMjMwYzIyODY0
Yjc1Ci0tLSAvZGV2L251bGwKKysrIGIvbGliL3N0cmluZy1pbnRlcm5hbC5oCkBAIC0wLDAg
KzEsMzEgQEAKKyNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPgorCisvKioKKyAqIHN0cm5jYXNl
Y21wIC0gQ2FzZSBpbnNlbnNpdGl2ZSwgbGVuZ3RoLWxpbWl0ZWQgc3RyaW5nIGNvbXBhcmlz
b24KKyAqIEBzMTogT25lIHN0cmluZworICogQHMyOiBUaGUgb3RoZXIgc3RyaW5nCisgKiBA
bGVuOiB0aGUgbWF4aW11bSBudW1iZXIgb2YgY2hhcmFjdGVycyB0byBjb21wYXJlCisgKi8K
K3N0YXRpYyBpbmxpbmUgaW50IF9fbGliX3N0cm5jYXNlY21wKGNvbnN0IGNoYXIgKnMxLCBj
b25zdCBjaGFyICpzMiwgc2l6ZV90IGxlbikKK3sKKwkvKiBZZXMsIFZpcmdpbmlhLCBpdCBo
YWQgYmV0dGVyIGJlIHVuc2lnbmVkICovCisJdW5zaWduZWQgY2hhciBjMSwgYzI7CisKKwlp
ZiAoIWxlbikKKwkJcmV0dXJuIDA7CisKKwlkbyB7CisJCWMxID0gKnMxKys7CisJCWMyID0g
KnMyKys7CisJCWlmICghYzEgfHwgIWMyKQorCQkJYnJlYWs7CisJCWlmIChjMSA9PSBjMikK
KwkJCWNvbnRpbnVlOworCQljMSA9IHRvbG93ZXIoYzEpOworCQljMiA9IHRvbG93ZXIoYzIp
OworCQlpZiAoYzEgIT0gYzIpCisJCQlicmVhazsKKwl9IHdoaWxlICgtLWxlbik7CisJcmV0
dXJuIChpbnQpYzEgLSAoaW50KWMyOworfQorI2VuZGlmCmRpZmYgLS1naXQgYS9saWIvc3Ry
aW5nLmMgYi9saWIvc3RyaW5nLmMKaW5kZXggNDg1Nzc3YzlkYTgzLi43MDViNzk5ZTNiNWMg
MTAwNjQ0Ci0tLSBhL2xpYi9zdHJpbmcuYworKysgYi9saWIvc3RyaW5nLmMKQEAgLTI5LDYg
KzI5LDcgQEAKICNpbmNsdWRlIDxhc20vd29yZC1hdC1hLXRpbWUuaD4KICNpbmNsdWRlIDxh
c20vcGFnZS5oPgogCisjaW5jbHVkZSAic3RyaW5nLWludGVybmFsLmgiCiAjaWZuZGVmIF9f
SEFWRV9BUkNIX1NUUk5DQVNFQ01QCiAvKioKICAqIHN0cm5jYXNlY21wIC0gQ2FzZSBpbnNl
bnNpdGl2ZSwgbGVuZ3RoLWxpbWl0ZWQgc3RyaW5nIGNvbXBhcmlzb24KQEAgLTM4LDI1ICsz
OSw3IEBACiAgKi8KIGludCBzdHJuY2FzZWNtcChjb25zdCBjaGFyICpzMSwgY29uc3QgY2hh
ciAqczIsIHNpemVfdCBsZW4pCiB7Ci0JLyogWWVzLCBWaXJnaW5pYSwgaXQgaGFkIGJldHRl
ciBiZSB1bnNpZ25lZCAqLwotCXVuc2lnbmVkIGNoYXIgYzEsIGMyOwotCi0JaWYgKCFsZW4p
Ci0JCXJldHVybiAwOwotCi0JZG8gewotCQljMSA9ICpzMSsrOwotCQljMiA9ICpzMisrOwot
CQlpZiAoIWMxIHx8ICFjMikKLQkJCWJyZWFrOwotCQlpZiAoYzEgPT0gYzIpCi0JCQljb250
aW51ZTsKLQkJYzEgPSB0b2xvd2VyKGMxKTsKLQkJYzIgPSB0b2xvd2VyKGMyKTsKLQkJaWYg
KGMxICE9IGMyKQotCQkJYnJlYWs7Ci0JfSB3aGlsZSAoLS1sZW4pOwotCXJldHVybiAoaW50
KWMxIC0gKGludCljMjsKKwlyZXR1cm4gX19saWJfc3RybmNhc2VjbXAoczEsIHMxLCBsZW4p
OwogfQogRVhQT1JUX1NZTUJPTChzdHJuY2FzZWNtcCk7CiAjZW5kaWYK

--------------eWVLiKb8hW4mlc5kPUXDDJhx--
