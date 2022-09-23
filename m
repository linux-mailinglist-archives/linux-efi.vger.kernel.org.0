Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6F5E85A7
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 00:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIWWPV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIWWPT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 18:15:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48C8A1D4;
        Fri, 23 Sep 2022 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663971318; x=1695507318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=MtBRKKdnqYxxNiz0x4/t45LC5G3Cq5V/UOyckqNmC0g=;
  b=fXWbMLR4KL+hynQ6GvuE9+tZyEBiJgBrW5WbY3dODWOiGVFByiKUO1rh
   o/htb5DP4V5pZ3e/GVK+21x0RQxwpBnC68UrFCV6ed88gA4OgkYITkJBd
   gi1Huy1HYt5ws2sytksur0UkDOrvb0TWDBj5saF9dvr94tAPBzeNUCZZx
   QFwSQemNxXWpZ8QN/w6fhMLKi8qCVwPZQ4j59BEX9udoWXP4ISv6ReYtC
   jI4a/zhdtajO7RFPWOJvn30WySKepZMIuTxa9OO/8X1Nu41xekFmyi8Qc
   RQuBsxr1yFh/VzvMmCTCT60E5EgXqx5LZYI9cI7/rNhBbPaRdbo2L+2O5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299430832"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="299430832"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 15:15:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="688887052"
Received: from hanjulee-mobl1.amr.corp.intel.com (HELO [10.252.138.32]) ([10.252.138.32])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 15:15:15 -0700
Content-Type: multipart/mixed; boundary="------------lWLJHMUVkbxe2CYJ8fAKF5Dq"
Message-ID: <69e00173-087e-6a22-7a02-0c1212f42065@intel.com>
Date:   Fri, 23 Sep 2022 15:15:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
 <20220922193157.1673623-1-dave.hansen@linux.intel.com>
 <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
 <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
 <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
 <5f443915-b38a-c78d-cccd-876501434cef@roeck-us.net>
 <CAMj1kXEt1RwYbkBOFa=KsML0KvJ6Zuu9eJ_=jQA7BTW-N2BSeA@mail.gmail.com>
 <202209231126.6855D54@keescook>
 <CAMj1kXHckEg6rwBSEc6piu=-JZzyDh7j+pvGSFp1OBUQuofrEQ@mail.gmail.com>
 <202209231417.F73F40060@keescook>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <202209231417.F73F40060@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a multi-part message in MIME format.
--------------lWLJHMUVkbxe2CYJ8fAKF5Dq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/22 14:19, Kees Cook wrote:
>> But currently, PAE is not even enabled in the i386_defconfig, and
>> defaults to off. This means people that are unaware of this won't
>> enable it, and will be running without NX support.
> And they all make me cry. ;)

It's been like that for a long time, presumably because the defconfig
should *boot* in as many cases as possible.  It wouldn't be hard to
change.  It also wouldn't be hard to default to HIGHMEM4G (non-PAE) on
targeted builds for CPUs that don't support it.  Patch attached to do
that, if anyone else has an opinion.

We should probably just leave i386 alone, but it breaks my heart to see
Kees in tears.
--------------lWLJHMUVkbxe2CYJ8fAKF5Dq
Content-Type: text/x-patch; charset=UTF-8; name="pae.patch"
Content-Disposition: attachment; filename="pae.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnCmluZGV4
IGY5OTIwZjEzNDFjOC4uZmFkOTc4YzdiN2M1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9LY29u
ZmlnCisrKyBiL2FyY2gveDg2L0tjb25maWcKQEAgLTEzNjMsOSArMTM2MywxNCBAQCBjb25m
aWcgWDg2X0NQVUlECiAJICB3aXRoIG1ham9yIDIwMyBhbmQgbWlub3JzIDAgdG8gMzEgZm9y
IC9kZXYvY3B1LzAvY3B1aWQgdG8KIAkgIC9kZXYvY3B1LzMxL2NwdWlkLgogCitjb25maWcg
Q1BVX0hBU19QQUUKKwlkZWZfYm9vbCB5CisJZGVwZW5kcyBvbiAhTTQ4NlNYICYmICFNNDg2
ICYmICFNNTg2ICYmICFNNTg2VFNDICYmICFNNTg2TU1YICYmICFNR0VPREVfTFggJiYgIU1H
RU9ERUdYMSAmJiAhTUNZUklYSUlJICYmICFNRUxBTiAmJiAhTVdJTkNISVBDNiAmJiAhTVdJ
TkNISVAzRCAmJiAhTUs2CisKIGNob2ljZQogCXByb21wdCAiSGlnaCBNZW1vcnkgU3VwcG9y
dCIKIAlkZWZhdWx0IEhJR0hNRU00RworCWRlZmF1bHQgSElHSE1FTTY0RyBpZiBDUFVfSEFT
X1BBRQogCWRlcGVuZHMgb24gWDg2XzMyCiAKIGNvbmZpZyBOT0hJR0hNRU0KQEAgLTE0MTIs
NyArMTQxNyw3IEBAIGNvbmZpZyBISUdITUVNNEcKIAogY29uZmlnIEhJR0hNRU02NEcKIAli
b29sICI2NEdCIgotCWRlcGVuZHMgb24gIU00ODZTWCAmJiAhTTQ4NiAmJiAhTTU4NiAmJiAh
TTU4NlRTQyAmJiAhTTU4Nk1NWCAmJiAhTUdFT0RFX0xYICYmICFNR0VPREVHWDEgJiYgIU1D
WVJJWElJSSAmJiAhTUVMQU4gJiYgIU1XSU5DSElQQzYgJiYgIU1XSU5DSElQM0QgJiYgIU1L
NgorCWRlcGVuZHMgb24gQ1BVX0hBU19QQUUKIAlzZWxlY3QgWDg2X1BBRQogCWhlbHAKIAkg
IFNlbGVjdCB0aGlzIGlmIHlvdSBoYXZlIGEgMzItYml0IHByb2Nlc3NvciBhbmQgbW9yZSB0
aGFuIDQK

--------------lWLJHMUVkbxe2CYJ8fAKF5Dq--
