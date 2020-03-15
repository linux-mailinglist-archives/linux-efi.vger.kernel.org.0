Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC9E185C96
	for <lists+linux-efi@lfdr.de>; Sun, 15 Mar 2020 14:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgCONWb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Sun, 15 Mar 2020 09:22:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:32835 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgCONWb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 15 Mar 2020 09:22:31 -0400
IronPort-SDR: kBje1bZfrXD6FHFiBBzmaQ6fUafWkrCPnHfOE7AWJKaK0W0DIXkW4b0F1G3bDQKQCGRuSpOy6K
 FbcSe5SFaNig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 06:22:31 -0700
IronPort-SDR: e65PpYj+KrPtb7PK3nQlnH8U4Znb+C+UZoGuoypqpWZ8f0GPr95xNBvrrBLKf14fLFjZna3seW
 CwhnEVULH8NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,556,1574150400"; 
   d="scan'208";a="237403138"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2020 06:22:31 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Mar 2020 06:22:30 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 15 Mar 2020 21:22:28 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Sun, 15 Mar 2020 21:22:28 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "ardb@kernel.org" <ardb@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] eif/capsule-pstore: Add capsule pstore backend
Thread-Topic: [PATCH v6 2/2] eif/capsule-pstore: Add capsule pstore backend
Thread-Index: AQHV+AtfIE8BGbnd7EuNivMeMNK86qhG6XKAgAK6+cA=
Date:   Sun, 15 Mar 2020 13:22:28 +0000
Message-ID: <fce0cdd3ed5745bf847e91085313ac02@intel.com>
References: <20200312011335.70750-1-qiuxu.zhuo@intel.com>
 <202003132014.DFC42ED@keescook>
In-Reply-To: <202003132014.DFC42ED@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> From: Kees Cook <keescook@chromium.org>
> ...
> Subject: Re: [PATCH v6 2/2] eif/capsule-pstore: Add capsule pstore backend
> nit: typo in Subject "eif" -> "efi". :)

Thanks for finding the typo. :-)


> On Thu, Mar 12, 2020 at 09:13:35AM +0800, Qiuxu Zhuo wrote:
> ...
> I can't speak to the EFI capsule bits, but I looked through the pstore API usage, and it all looks good to me. 
> With the subject typo changed, please consider it:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> -Kees

Thanks for your time on the review!

-Qiuxu
