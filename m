Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3AA1E5130
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgE0WaV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 27 May 2020 18:30:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:9372 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgE0WaU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 May 2020 18:30:20 -0400
IronPort-SDR: 2fq4SKqycdEiCmNoOeImZHuo+u2fd6Uw/AI/5nGQnpPMis0CCHECcC8v3AEUIboMMxT4dGlzch
 vCQ2EpOoCTEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 15:30:20 -0700
IronPort-SDR: arn4Bo0jnxZUN0jzjB1ppZJVRvXE8vVaao7RnH7euAqVJOWIVNEmNGQqHqYeZ1OEJra6K7g1oQ
 CElSDyC/wSKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="256885314"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2020 15:30:19 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.106]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.173]) with mapi id 14.03.0439.000;
 Wed, 27 May 2020 15:30:19 -0700
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "joe@perches.com" <joe@perches.com>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH 08/15] efi/x86: Move command-line initrd loading to
 efi_main
Thread-Topic: [PATCH 08/15] efi/x86: Move command-line initrd loading to
 efi_main
Thread-Index: AQHWNHZm0cvj4qcSIk2dwmAeFoTM9A==
Date:   Wed, 27 May 2020 22:30:18 +0000
Message-ID: <10a1c7fcea861f5d45dff81cba673e970d686bc2.camel@intel.com>
References: <20200508180157.1816-1-ardb@kernel.org>
         <20200508180157.1816-9-ardb@kernel.org>
In-Reply-To: <20200508180157.1816-9-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.38.97]
Content-Type: text/plain; charset="utf-7"
Content-ID: <E70E39CBD7C0D543B1E1BBF4835CD7BC@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2020-05-08 at 20:01 +-0200, Ard Biesheuvel wrote:
+AD4- From: Arvind Sankar +ADw-nivedita+AEA-alum.mit.edu+AD4-
+AD4- 
+AD4- Consolidate the initrd loading in efi+AF8-main.
+AD4- 
+AD4- The command line options now need to be parsed only once.
+AD4- 
+AD4- Signed-off-by: Arvind Sankar +ADw-nivedita+AEA-alum.mit.edu+AD4-
+AD4- Link: 
+AD4- https://lore.kernel.org/r/20200430182843.2510180-9-nivedita+AEA-alum.mit.edu
+AD4- Signed-off-by: Ard Biesheuvel +ADw-ardb+AEA-kernel.org+AD4-

Hi,

This patch patch in tip/master as:

987053a30016 efi/x86: Move command-line initrd loading to efi+AF8-main

...regresses my nfs root configuration. It hangs trying to mount the
nfs root filesystem +ACI-root+AD0-/dev/nfs ip+AD0-dhcp+ACI-.

It does not revert cleanly.


