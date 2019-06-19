Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E80244C055
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jun 2019 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfFSRxj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 19 Jun 2019 13:53:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:28092 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfFSRxj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Jun 2019 13:53:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 10:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,393,1557212400"; 
   d="scan'208";a="150675667"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga007.jf.intel.com with ESMTP; 19 Jun 2019 10:53:38 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.32]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.70]) with mapi id 14.03.0439.000;
 Wed, 19 Jun 2019 10:53:37 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Qian Cai <cai@lca.pw>, "bp@alien8.de" <bp@alien8.de>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/efi: fix a -Wtype-limits compilation warning
Thread-Topic: [PATCH v2] x86/efi: fix a -Wtype-limits compilation warning
Thread-Index: AQHVJscrIoiFrvq5WUaaeJ1Am5nx9KajQcjQ
Date:   Wed, 19 Jun 2019 17:53:37 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F787D4B@ORSMSX114.amr.corp.intel.com>
References: <1560966464-27644-1-git-send-email-cai@lca.pw>
In-Reply-To: <1560966464-27644-1-git-send-email-cai@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTllMWE0MzEtMGUxMi00NDE2LWFjOTktN2U2YmYxMTBmMWM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMHk2d0w4QnFPaXVtTVJUNFZpVTJHVERLWDhlTXJvcVUwdlFkc3FIZGtPYnlMOHNKUWFERkRJaXh5T0RwdTFNeSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> Compiling a kernel with W=1 generates this warning,
> 
> arch/x86/platform/efi/quirks.c:731:16: warning: comparison of unsigned
> expression >= 0 is always true [-Wtype-limits]
> 
> Fixes: 3425d934fc03 ("efi/x86: Handle page faults occurring while running EFI
> runtime services")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Add a "Fixes" tag.

Makes sense.
Thanks for the fix Qian Cai.

Regards,
Sai
