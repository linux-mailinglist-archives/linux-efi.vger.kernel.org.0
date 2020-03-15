Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF2185C94
	for <lists+linux-efi@lfdr.de>; Sun, 15 Mar 2020 14:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgCONUl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Sun, 15 Mar 2020 09:20:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:4372 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgCONUl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 15 Mar 2020 09:20:41 -0400
IronPort-SDR: pbFVnCkXChS9yhh5IQCqux6HbqBjWbw633rqXm1pTvwlqwgqg6GfqY18DRusa0kWQME8HDeN9Y
 qKjTrM73sCxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 06:20:40 -0700
IronPort-SDR: oetZumnJebBpPskjZ34t9uSTsqH2RwVT0xCGSlbToP2DSsqTw2rK7pQR5/HT04K0/emw9k+L4E
 yy4aFz/vnlTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,556,1574150400"; 
   d="scan'208";a="232910924"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2020 06:20:40 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Mar 2020 06:20:40 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 15 Mar 2020 21:20:37 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Sun, 15 Mar 2020 21:20:37 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "ardb@kernel.org" <ardb@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] efi: Add 'nr_config_table' variable in efi
 structure
Thread-Topic: [PATCH v6 1/2] efi: Add 'nr_config_table' variable in efi
 structure
Thread-Index: AQHV+AtZNdca73ftgkurIc1TPG8omahG6bOAgAK+jsA=
Date:   Sun, 15 Mar 2020 13:20:37 +0000
Message-ID: <11ea78c630fc46c4bbbd837c06130082@intel.com>
References: <20200312011324.70701-1-qiuxu.zhuo@intel.com>
 <202003132023.68BFCB0@keescook>
In-Reply-To: <202003132023.68BFCB0@keescook>
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

> From: linux-efi-owner@vger.kernel.org <linux-efi-owner@vger.kernel.org> On  Behalf Of Kees Cook
>> ...
> >  	unsigned long runtime;		/* runtime table */
> >  	unsigned long config_table;	/* config tables */
> > +	unsigned long nr_config_table; /* the number of config tables */
> 
> nit: please use a tab character before the comment to get correct alignemnt.

OK. Will correct it. Thanks!

-Qiuxu
