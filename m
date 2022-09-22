Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA25E6D6B
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 22:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIVUyt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 16:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIVUyt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 16:54:49 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 13:54:44 PDT
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD351EAEA;
        Thu, 22 Sep 2022 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=214; q=dns/txt; s=iport;
  t=1663880087; x=1665089687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sqs253CY96Q1O/q/QDBGUIXsu2oS9qGI4DV9xBwjf8E=;
  b=SIyCfYlql56Hb79hNvz8Kb/cgvjAq4jOOAI+6CCd4o1CFak1NjsFg67R
   cQbGFmyC284EQlVrtGH2adfEjGeomlUJ7m/tsKkXpPmw2bZXMwBKCgxwF
   vIjcJsgJni8YSi7UhfaFusxjtcMEFdMdaY0lLOjCRcGaZdn2YIWKjOc+i
   I=;
IronPort-Data: =?us-ascii?q?A9a23=3A+QmIHqlUxhL975HU6NU2Mt/o5gwRJ0RdPkR7X?=
 =?us-ascii?q?Q2eYbSJt1+Wr1GztxIbWmqDMqncYGKje90jO4y28k9Q7ZXdnYJiHgVt+Hs8F?=
 =?us-ascii?q?VtH+JHPbTi7wugcHM8zwvUuxyuL1u1GAjX7BJ1yHya0SiuFaOC79yEhjP/QH?=
 =?us-ascii?q?9IQNcadUsxPbV48IMseoUoLd94R2uaEsPDha++/kYqaT/73YDdJ7wVJ3lc8s?=
 =?us-ascii?q?Mpvnv/AUMPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnRE?=
 =?us-ascii?q?mLx5RwhDJaulaz2NxZMSb/JNg/IgX1TM0SgqkEd/WppjeBqb7xFNBs/Zzahx?=
 =?us-ascii?q?7idzP1BvJqxRAM2N4XHmf8WVF9TFCQW0ahuoeeZeSnh6ZfCniUqdFOpmZ2CF?=
 =?us-ascii?q?noeOYwe5/YyDG9P3eIXJSpLbR2Zge+yhrWhRYFEgsUlMdmuP4kCu3Vs5S/WA?=
 =?us-ascii?q?OxgQp3ZRajOo9hC018Yis1QHP3Te9AUZBJxYxnaJR5CIFEaDNQ5hujArn3+d?=
 =?us-ascii?q?SBI7VGYv6w650DNwwFrlrvgKtzYfpqNX8o9tkKZoH/Wum3jB1QZOcaZxD6t9?=
 =?us-ascii?q?nO3mvSJnCX1QoseGbS0sPlwjzW7xnQaIA8HSVyh5/K+jyaWX9NZNlwM4iFro?=
 =?us-ascii?q?aUs3EiqVcXmGRqqpHeOpVgbQdU4O+k77hydj6/V+x2xGGcJVHhCZcYguctwQ?=
 =?us-ascii?q?iYlvneZz43BBjF1trCRD3WH+d+8pDCqPAARLGkfdWoKShYD79D/oYY1yBXVQ?=
 =?us-ascii?q?b5LHKezj9DxMT7xxiiHqCUghr4Ty9UC0eC151nBiDO3rZ+PRQdz+x6/dnii5?=
 =?us-ascii?q?ANRZ4O/YYGsr1/B4p5oJ4aDT0Kdu2AElo6a4foJHLmGjyOXR/gVWry0j96aM?=
 =?us-ascii?q?TnYqV1iBZ8s83Kq4XHLVZtd6Tc4LUFlP9wffjnBe0LYvkVa45o7AZcARcebe?=
 =?us-ascii?q?KqrAMgsiKPnD9mgDbbfb8FFZd56cwrvwc2nXmbIt0iFraTmufhX1U+nTPuR?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0OKxI6lzC6qbR1gI60DyR8DKK4jpDfIp3D?=
 =?us-ascii?q?Abv31ZSRFFG/FwWfrAoB0+726QtN9xYgBDpTnuAsO9qB/nmKKdpLNhWYtKPz?=
 =?us-ascii?q?OW21dATrsC0WKK+VSJcBEWtNQ86U4KScZD4bPLYWSTSa3BkW+F+xFK+qjhzJ?=
 =?us-ascii?q?yV?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AkBgBDbIJi/5pdJa1aHQI9BQUECRa?=
 =?us-ascii?q?BTwKCKYFLPUOTNIIokUeLHYF8CwEBAQ0BARIwBAEBgU6DNAKFPgIlNAkOAQI?=
 =?us-ascii?q?EAQEBEgEBBQEBAQIBBwSBCROFdYZDAQU6PxALGC5XBhOGFatWeIEzgQGIGYF?=
 =?us-ascii?q?lJIEYAY5fJxyBSUSEPz6KfwSVYzsDVIEFEoEhcQEIBgYHCgUyBgIMGBQEAhM?=
 =?us-ascii?q?SUx4CEwwKHA5UGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDGAkHCgMdCAo?=
 =?us-ascii?q?cEhAUAgQTHwsIAxofLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwE?=
 =?us-ascii?q?GAwYCBQUBAyADFAMFJwcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAnE?=
 =?us-ascii?q?KKA0IBAgEHB4lEwUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY?=
 =?us-ascii?q?2GQEFXQYLCSMcLAsGBQYWAyZSBiIBsVONGJ4qg1aBQ54tSxGDUgGkc5Zmpn4?=
 =?us-ascii?q?CBAYFAhaBYTyBWTMaCBsVgyNRGQ+dECQxOwIGCwEBAwmRGgEB?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1060960399"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 Sep 2022 20:53:37 +0000
Received: from zorba ([10.25.129.98])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 28MKrYsJ003891
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Sep 2022 20:53:36 GMT
Date:   Thu, 22 Sep 2022 13:53:34 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/8] generic command line v4
Message-ID: <20220922205334.GV4320@zorba>
References: <20210416040924.2882771-1-danielwa@cisco.com>
 <b517fac5-2fdc-a8c9-75d0-174c67f5a2de@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b517fac5-2fdc-a8c9-75d0-174c67f5a2de@seco.com>
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-3.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 22, 2022 at 04:45:01PM -0400, Sean Anderson wrote:
> 
> 
> 
> For an arm64 platform (after rebasing):
> 
> Tested-by: Sean Anderson <sean.anderson@seco.com>

Maybe I'll re-submit it.

Daniel
