Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7CE7D89E1
	for <lists+linux-efi@lfdr.de>; Thu, 26 Oct 2023 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJZU4i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Oct 2023 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZU4g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Oct 2023 16:56:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C041A5;
        Thu, 26 Oct 2023 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698353795; x=1729889795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OtgFnyJKY0gcEcXhfmabhazPmpzjfGCAmRZ1nHmckPI=;
  b=V5VY5s2sz6AwCKu5MdRKa4B7QOuQyYldLnGqGUPUJZZWdjxsuqoBIIfh
   DBbImAZiAosc3/kd5F4Ohy5jWQXYhdnOKEWnmIhttRbVIAOaduphSue9v
   PHU6suPrJbR0t0h4sCLI+22I9PgX63Foy9wTP0T/2kh+7xNlMqCJLiMuK
   0wicNXOPs/f6C8OjiPytrdIRpwVBqlX0/+k4IKV2wuzcN7k9OR8jbiiUR
   QKLeUVo2Bxu719qShx4Qw62n0yJsQllf3fiXnsetvVe4oQC7i9F8kTGTk
   XnI21TA6O1V6L7RU3ER8XVjsS4suTA5ziIIXG2rx8x7dOlEZ9BRZN+5oj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="6269709"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="6269709"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 13:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709210281"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="709210281"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 13:56:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 13:56:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 13:56:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 13:55:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3ufZKcUM4Az59VfyRKh9AAYpyl7jh8orGafT7xavBzwc1Tf9eOrL4BbdUOebsjz91rKAyiqkeeff+8jL7uPOvuhxRVimBr9mTXInOm7InrG78hxsnJQdorMR9bH9oUd8fJG/dP3uWekNFxnSiw1uzMGGtnUj7cpmVYRasasRIYt87Hmtkrt5mEzMVPA+vtKw7Fu9pgYakgcstWLtadV7YEyCRo2Pihps3w5daJoADe0r8SjVx8NjlWFBAHZg9aqwKcLDn3S481VFlUqF/iJ9MQU+P1Kq60u2sLDeeysB1FBHAwE5NzexkIQyCBt0An0Q45pXX91D7lQvpltZEitYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPfa6U5cdYjCrqsjSwTF507spDNaRqMpmovmT3rdZCU=;
 b=mQnMJ7krLHY3wuFsj40r1Sl03SXlTqZkgCj+0dHc+KnWxjMKk/LubvHWAV5S6+DF8hCI1hiZ75BGd/CTaIC6EGTGcoMXz5hL6lGcFsAwzEruC8T2Zkyww6F9h8ReckeBqXmj7Lwg/RR4cguFbQRO+m7BMSOvjLNJCsU2ybUnBs62u9RmZAONyiJWV8vxiRCqGb5L1nFUrOT/i8+zT+j4xe3vm8qZEHpYUBggBD3Wal5nTGnZcDWpL5xq/Xy4ADHfMP0ADSUaF0YZvETHJQ+t1GQcTJmLV9/6GiBtkCMX8eXnKyb0PKTvMt1l82LVGkYjzRO7yCtkbVvRPAPnz68C1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5632.namprd11.prod.outlook.com (2603:10b6:a03:3bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 20:55:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 20:55:51 +0000
Date:   Thu, 26 Oct 2023 13:55:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH RFC v2 1/3] cxl/trace: Remove uuid from event trace known
 events
Message-ID: <653ad255b805_780ef2942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-1-314d9c36ab02@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v2-1-314d9c36ab02@intel.com>
X-ClientProxiedBy: MW4PR04CA0387.namprd04.prod.outlook.com
 (2603:10b6:303:81::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: cca92703-418f-4fda-3015-08dbd665f02c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3VRLb7392WA2lwQk+7ucAZbtiAwRohiEunN0/43kDQIPJS+X0tJWxjQVruiOVul4MMRPQFsypk5WvLKepRllEny/REcGVLEYktqjQ47Cw45G8ZsJgtnvWvNXW/TDU4pT4HF3YEN8iM6dCaCqr5dvfZY+jcgcfuU40eV9jULsH88QJUtclXZTJLpvcaMkn6LUrXxiMl5VotvRcrv+g2spyTCc/PlWC0urT9Pc6/AyHgEuIHyjRTWePpCt3iYK/GMh3eHFA1XJn3zlpPHDwbgZPNGpH0UG0ovM6Xb0bStTTciDZh7J3cigHbmE/M9rwc8jAJVvgFoDyUyEYUOQiApi85hH1sKxYxd0qcvF2naWaT0DC/d12FEUQ1g+1ER5Y6LzF6amEFpc+ZN7NUUZ8MnoSAeCR99fYnBTpfw1qrvtuonB9ZzgzDfSdM4Z5v1XZjSXyxyK/UgHj6H20wDFs7zcTfNvPYROte6cFgSAaSnKMoAbqkQqMfQDEkNwMJry60y3w85mXPL38LHKsaLk2IEAA9AIDr4yeQYRolpRkqjOwFWiBiR7FzyMfjKTDuEv1/q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(4326008)(8936002)(8676002)(6486002)(107886003)(4744005)(82960400001)(41300700001)(9686003)(5660300002)(6512007)(86362001)(6506007)(316002)(110136005)(478600001)(26005)(54906003)(66946007)(66476007)(38100700002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e1GceitR8ymXijn+iZtCJx12huMMH7q9ivTM9m+CCg28L5yMEKyUXdkRVcJu?=
 =?us-ascii?Q?nem32DQ3OIwJIHNaU9F0AfkWsEqZ0k7tHJZZU19B6cGBMRGNH/0PD4dbhzM1?=
 =?us-ascii?Q?fJzNFRS7X6IEGJuU5Usyky6foB1aPbSjOpWJoFo8iIdhgoI9f78czX+MwrJE?=
 =?us-ascii?Q?T3SO32VPZAOyQ8Ta+buheLOXmUimP+/OtWhEBJEgGDZ1YNTDmtQraSHOhv1M?=
 =?us-ascii?Q?1nucfH0ytYXflBjc+RhbyVCC9pc42U/hT71xyxTPSv37lJ/Qmk+kRKN+NMkS?=
 =?us-ascii?Q?hKxIQ3XpoWWv6eD0p+DDAs9DgRJ/nDyXa+pw2dVcmGl7vET7rq4mDb7z9jiZ?=
 =?us-ascii?Q?VL5b7mD5DXJyHbh194zUg/Ekt6qtY13f4+iRr66KfNdieCJ/3Izlxw3QFcHL?=
 =?us-ascii?Q?p9BEMAsF6VP0CQGR3pGKYUQKSlPtZKXCdNZAspYaJgq7BoJQ3QxpyGUndBUY?=
 =?us-ascii?Q?2m8DXfMUdlG+E2vl8YDWZ1YGcoLphAF8Rlq3ao074U58AZrAXnri5NwtnzVL?=
 =?us-ascii?Q?D+pOjf+Sobqo3PzjAeANDyEclgPe5tsoj0RP1vCxatmemUua65NwCLLh0m2t?=
 =?us-ascii?Q?7etxawnT0HddPo2MbuO7OI4HwamVAI7I70tK9Wo2Ad83PEOa4sotnzotD1y5?=
 =?us-ascii?Q?4fJ7y+WiydHOw27ACy1fZvUBWLhcqH4lSJQJJB7Mz7RsKDuPjLVmpgr2TdAi?=
 =?us-ascii?Q?f2/6DyUJTO0P5vUg7bGYqRDpkPDO7sCYLOeY3/jLBRtmHP+gIPtOkNSPU+ii?=
 =?us-ascii?Q?G5lRlNgkahfgnRen3G8gjPGLaLgNg2/3PD+MuO76qX04YBuLTU6Ywho/fbPz?=
 =?us-ascii?Q?QmFGlle3Xf0Bgvxeir8dBx7vj03OQyuYpeZLmJ//AmNovZZnSHRHz+ybhvjW?=
 =?us-ascii?Q?nhtlG7A0F0mKmHd4B3K6X+BtPDzGBTqlxMOjBOxfpb0+BiMUgmUNf8ovabaR?=
 =?us-ascii?Q?LC1ghc+b9mYEAA6UHzN/2q+kSN0Mqk/ec+M35iuEarr3YaWctyRIe4WHMqUQ?=
 =?us-ascii?Q?h43B6sP1M8SZBw44FFA7UBJy5NnpKk/SdzcVXUZHCoS70ym2XdSsec1qw7PG?=
 =?us-ascii?Q?7Ba0KfqgqAQBiiB+G/o0hHfXoJa3KBq9laGcdgl76e2ep/JFJKG7twnawKjy?=
 =?us-ascii?Q?FLTKwveEhnFlJug0dLE6hUF58PqjXCvmj9jw/e70jBjkW3E3WgpWBwD6SUf0?=
 =?us-ascii?Q?qBRjqtGbbYGxkKWr1kcJUdKuSIQYYSNAMar78W6HPx6cwrRkIX+E8qlNM8ja?=
 =?us-ascii?Q?rbFuXp8/m6CBjYRi2qyBJEAZm7Poo4/YhTAjIX3Gsykl/hlHVJkD7+yu5Ear?=
 =?us-ascii?Q?QqzBJ9J8vi4T3lvzqWi4MrY2hS1vmLEjLA6iXOY7cqJnOzIqSQPqjDRKoxax?=
 =?us-ascii?Q?KBcKqcLCEdmtgNjNNPN3dKAUO52VqaL4LQtzxTh0vVogdZuxzQ1XOde1Hn6f?=
 =?us-ascii?Q?1PLyv2LfIH/x+g059LMsmND5Zg502oDS6LlP5GUmA2p68knsQX6ii62fWyJp?=
 =?us-ascii?Q?1W2pK2peB8XBhuMcG8h6OPbQUZMynsWcmUqEhkEvki/sx4pdzF+C2E//dhhs?=
 =?us-ascii?Q?xcB6eynFLFA4siEbFTJc9gtyOnuHQ6vdCPXXcBOYl6riHq4ZBkqfiAM0AlwZ?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cca92703-418f-4fda-3015-08dbd665f02c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 20:55:51.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/wV1k1+0I2Zbzr+Ma5aBYbjlfW/Dd1W1jNvSEjnAIWMYmatXmFbb5Wb8WB7S+tmexr47zFwMtB9BKHhYZLwT8MpgIJvy/QF1iUmVdtyYPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ira Weiny wrote:
> The uuid printed in the well known events is redundant.  The uuid
> defines what the event was.
> 
> Remove the uuid from the known events and only report it in the generic
> event as it remains informative there.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
