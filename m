Return-Path: <linux-efi+bounces-1891-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC57298E7A5
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 02:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57022B25797
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 00:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E56DC2C8;
	Thu,  3 Oct 2024 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBpQPB4Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F348F5C;
	Thu,  3 Oct 2024 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914621; cv=fail; b=WTH9g+5qrMl5MuqU7JP81XBu5qRHwgIAb5e+oB38oxcF1bifi9AYGf0+Z/a5MheMBpsTPUik0neux4IEHek9Syp6XZTCZ9Fvmw3pm0MUKY8eImrlc9lSiWed4NhTomxD01SnoGyl4mce8/Zt3T41vwzw2oKRjcipIqiKdT76MH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914621; c=relaxed/simple;
	bh=Q/jJcTxPyIxErqzYks3SjkefAFKortg1Vjs/cl7oVDI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TwTDkZKzp2u6JUyUkFtMBFt/Qfqn1H9raC4EsSiJZ2ZLHklkZr2SnGMvwE20aBUY0IvzYU0b11Rw5XpErCuxgGdzgOaqAL35B1R1uuT4f1qeIe4J2bwy7ipe1rq70K0JTyDPfcygjxW86aETwg7XqZblEx73Ur4wURKuTzojjJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBpQPB4Q; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727914620; x=1759450620;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q/jJcTxPyIxErqzYks3SjkefAFKortg1Vjs/cl7oVDI=;
  b=lBpQPB4Qg12eQ+soW/eB+2kv1robAl1eVx5Eb0GKQQhhmBID62HH/1WK
   KN5v2qqH/cx4WBbV264SDNu7UAw+arVgliWneEfLaboD/fpuGsJAt8C+h
   vWBSTEgt7tgxIVHfPCcJPtW4L5QpKTQW1Qb/zoDQ/RiGtrnLixI0opSWg
   F+qesJEq6hTAu+I/vcfvgYTs+5E25+JwJK9VBwSjO93JHVqGuOKeTpw4j
   cPgsCXbmP04rR4jT0FyJeWfVaLTYDFgVl79z1kIHrBd3wMhZhPwl/x+zM
   Bc0ASmFWbNCHxGutaoIZ/AMWH8dGXkMWh+1T2RskACEDw0/qYN39In7No
   g==;
X-CSE-ConnectionGUID: 97HPcRyhSvCrnIbDu/q8zw==
X-CSE-MsgGUID: KydxMi5WQ9qcsCzaSyr1rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27251481"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27251481"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:16:59 -0700
X-CSE-ConnectionGUID: TjruZU9BRMm0e/8r2qcEdg==
X-CSE-MsgGUID: 5W4+vTa0TqWVH79VexT9eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74175131"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 17:16:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 17:16:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 17:16:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 17:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOZrvMAXXqrJZg6JaPJdUjiiIwxsDpR7mL7M+g/QePeh1yswLJk9AwSRUUAmpgHvc6bjOrXrJlB9sFzpEAeD7h79pVi7BGlAxoYyJ86Ft6B7YJ78E/owDV7eW5CQUL8nIArEm8EnFJzv04DsUV22OQFRYUGfGehuT70AKIItRCFt7XGpnhLTEtcCAOpdu4YpH00oOGoD002Dwm2CNzacsLya9uWGKSudHIS5zegcWw9cFsA22ZQ3q1flBifZ2ZLEIbRBJe/HbL3/TpHs1pCfTQIkAwkQSIAgT/B0n7CZX1UCwIWlZNCAWEtRnYVze65riDjPwMFyqyPW3oBEnboHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn3Oe45XWX9hRRIeP/nQhKRhCpOz4zbxMQg8A0fRkjk=;
 b=uxtGkJcBtPsIcgm1HsIv9eKB3vJ3iYhITBTD5JEvU8oyBIz/ZdoTd7ZNxsEep5AGQojb6hRqpPXTzmhBy54jMwjQt9W18gjj3dwm8jc6Z3O47FPWQ67oYXtIGRDah1MIBrPTrcS/Zniwz5mBDlJjxxDJCq7EJMHePJLFyvvJ6EHfitYDeTQ+iWFV6GT0hB9IhISHXS3c0V0qWXqkbwfYuS2QCpc3IkGSD+MJI0BcTrUSoBdHh591KBNCjetOazBxqg9pi8tC2caFFPWmk0jI43lEPtnV6K1E+6sJuTD8SutWUaDynwmmFBlCrwXhK9kitJP+aPSm5Mp1wRXYzYA19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8277.namprd11.prod.outlook.com (2603:10b6:806:25a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 00:16:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 00:16:55 +0000
Date: Wed, 2 Oct 2024 17:16:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
Message-ID: <66fde27512fa2_964f22945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001005234.61409-5-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3f1149-e3c3-4cfa-2b8f-08dce340b04d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lpzAmFtzG9PdypSLJ4F6xiMquEzV1L7yR/zrD0pwdouYR1GL08C76lDDD9bc?=
 =?us-ascii?Q?0lQBxfwPK/VfiG0oI935AHcolAWW7lxJIqtvU0zMNw/o0bkMKO8ZAyooAnQU?=
 =?us-ascii?Q?2wyjyBjSC0YVUnG128JaV+6nRMu2mQKMNyY8vTzTBS+bPQ27zlTMP9fYKssz?=
 =?us-ascii?Q?wmAzdjPYRb6khNLLRxesaYN/9rpAS3ZSuMY/vZ+4gQ+1bOkbned9l5NFzrd+?=
 =?us-ascii?Q?TpcQ4euJKmwp6/PHj39KziEbEE/mpRjw/6csvt4Mj0QhKIt5SOvhmgulYw2Q?=
 =?us-ascii?Q?3cSdUUePjGj+Wd2op0DfibVem63ID2IEHBHvVSFpcZkHPX8VOFWWykfN7ooB?=
 =?us-ascii?Q?gvZcjhR58HP4fNg5bIx0EqwliTrSzdUQVl40l9bJXtiooKsmGQEkZ8i0uQOE?=
 =?us-ascii?Q?bAqXgZv4MbF9e7QQTEHmnxbjp+DlqFxOx91JXrZl1jjToDkiNMHEqsUS7e+e?=
 =?us-ascii?Q?++coSRs8IWJWEmZeoJfDRIEt9Tq7j0SvLG0XrTXtYuWzKSEKSt9OOJULLuui?=
 =?us-ascii?Q?5xykpj5GMot1NPu0elJcEo4LCHE/hDLSS9E2LeE+YbBWUvcpuVWS+cAEvWwM?=
 =?us-ascii?Q?pD22i9csATyi8O0j9f5sToVFY3A8QGPWtLGxV6HhuzWhjFpsl+0svupyPyAG?=
 =?us-ascii?Q?B1Orlh8cTfjqvdTx5HdN6Glypn2BdMmtRJeTxxCWtSXiP0r2eAeppDRbuQQT?=
 =?us-ascii?Q?r9/qaypKw2zw8oHJjhDKQ/JYgIoURoE2wVI/zY0obSLX0mvqPKt+fFFi7Q9v?=
 =?us-ascii?Q?hwGoTTnxrQuxIH9BAhOb+aWpov1RAsN4ErKRH7jFidDnKZ5ia4PaAi9T2a5P?=
 =?us-ascii?Q?k5rfwUswiJRP3GMrixFw73BRFNW+QEBfmHx+Y7jIyaFMOD3muE4fzQjuNsGZ?=
 =?us-ascii?Q?Uvc4fIlbkSxImd7wH3zClvo/r6jRPccRL3LZ9MV+baB7UcvLMiYgehuR/Yqt?=
 =?us-ascii?Q?JPp5re5UiIuZDYJg5IYkYXSCpeRNAdq8cOASz/GBHDQSQOVFGv8ez1nFd9oC?=
 =?us-ascii?Q?HdN9fC6Ml5x+d/x5MEwM5WR/dTfI4frbT6lBSpzSO7A8hqsh6+PLFv/PoBcA?=
 =?us-ascii?Q?S2cZEhZpwjl7e+KuzS7pxeDTkPKrVkh0095FncvN2dQEwy+y9N9Wi8rOfrbD?=
 =?us-ascii?Q?Rk3W5Fk8F37clfSTHBXpC6CRXFyqvOdB1gD9K7ceUnIUUdeLKiPNHHEKkZ2h?=
 =?us-ascii?Q?SVR1niaxktqe8NeU/nkEx2XT16eVpLYV0jA5dmhrRwAaQJIj0efasOP8K0KM?=
 =?us-ascii?Q?heBL2hRzhNf7XEvMXpX/EmNpGyaopP5QsSKO1NRrPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I/zHUMs2hc1p3y6CgRD4NMSQDquLC0PvE6tqFgx8LYFTPpk4Uv5zPItpAZNq?=
 =?us-ascii?Q?hklkAk6w5HRsibcRDZG58Y40t8YQ8zwSu7YTZ8O1u24WHast1+eoB4ipJhJd?=
 =?us-ascii?Q?HOymp3i4eaFnFrzul2PmzQyZT2D4ZYyEziJnkvlIjUA2OsPxOVNuabQ/HfSI?=
 =?us-ascii?Q?+RD/xeyqhyYT3r1empP2JBuVrccCqcyZ5G2F1PqTfNARfsIBFsCZTqrbvAX5?=
 =?us-ascii?Q?uUo/ij41SALXrP/jzSTdZJ1sDLCqsCj3GLna+zAu0i++R3eyh8Vwzuh41ugY?=
 =?us-ascii?Q?8cSg34zNG90t5dmuvu9vsSE1qFdT/Mvmd3j59wY5cSpxXtK6m80ivb/wi5L/?=
 =?us-ascii?Q?wsQY/8NagTd6h07gcNmhwlF4H/Q9LWMksTpogcs5SKMATe2kt5ts7KwQvZAC?=
 =?us-ascii?Q?Kj7L1w3GQ/+yybEqzyqiI2K1IGB4cHoreiMl9vxdzZAXjMNdTJI+X0v34IGq?=
 =?us-ascii?Q?qhasNdEiGh7x68+KOTX23Yl/JVvQZVEbaAlcM3sPfNomkI0ELgUKfEc+EE08?=
 =?us-ascii?Q?hHSYCap3AkHb3bpFVPeUbUyuV2bQZ2rmz1Tp26ssv2KYS0c8qKnapNcWjRtK?=
 =?us-ascii?Q?zkNhjLJ6VliVyI07Wov+ArGYoIGuEDhrfpjuPkN2+SR2KGU+Bh45KRGKn26L?=
 =?us-ascii?Q?Ef+xZRguIU+9Z8ImPd3bblM73ecsVAust6PlGenSQotC5HiMXYFMXThyefpB?=
 =?us-ascii?Q?G41C4qenW/SqwmEumI4fFaZSjN7rn4DyXFcAEZhgtCj1r8GuQ711ISYWKsbW?=
 =?us-ascii?Q?jR//OaP3PFU5gqLRm1DT9aI3T5ml6bMm5MyBmVkUYFMZPpnsAixYIN00UBPN?=
 =?us-ascii?Q?ev4VH/OCHiFSj+FzoJCedlU5bQz7Oi7OC7FwDSL8bNHkIcN3afPsJPsxsCVH?=
 =?us-ascii?Q?HC3OBVltQ2TilM4M336UtxsI9SoklvXeWZompeWcpLygFBQxHVFn1LTrwrKJ?=
 =?us-ascii?Q?TrgYbm51QCFMljGvR0ego8rZ0mSbKF2yvyUkbU870Z07pbZOSdY1FpB/4K2w?=
 =?us-ascii?Q?OVR2msx8xLnZbYPBbtz3lzcMH0oeqSi7BbLCWaAnhxi39TO5w1E80lBotCRE?=
 =?us-ascii?Q?DfWKAoBmt/NjYLvlOPem0e0PuaniasQug/Bz3mP4aDlbqecURM3fY3j++VN8?=
 =?us-ascii?Q?oHWSBY7e5GhT9gOkHWnkkaJZ5OnDJDq/ESBw3AVSCQLyPyUHG/T2L7T8jPP7?=
 =?us-ascii?Q?ZhHTr2qwLUtsLnFWCj7Sxndi38FfpMclv79Itm+EqsBqpcTISjxV/Vt1qJOk?=
 =?us-ascii?Q?w6CpdIalO+V7MXiFy51Rq5H5zeCexUtHM4rqfNsArzWNWKMcRBmQ6iVkrvwT?=
 =?us-ascii?Q?4zI4f3GQrnULuVLaeh2vXLVOBLMMbM9XfmtZ6kNkSSnmKwoWkc4JGwjdU3tW?=
 =?us-ascii?Q?c5vEHWbtOURAH43A2oLukn8GiqrUEu61ZyPGi0LR0JqCjqTNkR9p3VtjPTTK?=
 =?us-ascii?Q?sIgfcRwSQofZnKNMPlR30Gjh0niSInyoA4AfXiGensJ39xt3/fZ8DcruukHn?=
 =?us-ascii?Q?sFJoN5uiFu1hU7buHFdu9ZQf81VuSyhfsONmbAV74535a6i6/FTQTQ307ewE?=
 =?us-ascii?Q?9m/zwBvkB1nY/OFLkjTuDcuVn4ab0haJ3XqolhmjvDF8ozhocvAo+j+3RTcg?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3f1149-e3c3-4cfa-2b8f-08dce340b04d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 00:16:55.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jj1RvlY/8BZf38TqezHSNB7JBSEkJ7qiBzW9Cr7u9EknQ6vZaUv99XrgXumC12ELAKbzFrtOw/jwLANw9eEc71T9VVBkCYQNAI6yA14j0go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8277
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records.
> 
> Reuse the existing work queue cxl_cper_work registered with GHES to notify
> the CXL subsystem on a Protocol error.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
> them to trace FW-First Protocol Errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Removed pr_warn for serial number.
> 	p_err -> rec/p_rec.
> ---
>  drivers/acpi/apei/ghes.c | 14 ++++++++++++++
>  drivers/cxl/core/pci.c   | 24 ++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h     |  3 +++
>  drivers/cxl/pci.c        | 20 ++++++++++++++++++--
>  include/cxl/event.h      |  1 +
>  5 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 9dcf0f78458f..5082885e1f2c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>  
>  	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
>  		return;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +
> +	if (!cxl_cper_work)
> +		return;
> +
> +	wd.event_type = CXL_CPER_EVENT_PROT_ERR;
> +
> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_work);

The cxl_cper_work item is only for cases where the cxl_pci driver might care
about annotating an error report with driver specific details like the
impacted kernel object name, 'struct cxl_memdev', or address translation
for DPA data.

Protocol errors that are not endpoint errors should never be placed in
the cxl_cper_fifo. That is exclusively for errors that cxl_pci needs to
consume.

My expectation is that similar to aer_recover_queue for PCIe protocol
errors CXL needs to grow a cxl_recover_queue that at a minimum triggers
new trace events to dump these records to RAS daemon.

I am struggling to think what useful information cxl_pci could ever
append to a protocol error event.

What is more likely is that later when Terry adds port error handling a
CPER protocol error record could trigger a new cxl_do_recovery() to
react to CXL topology errors that might impact downstream CXL devices.
In that case the notification will come through something like a new
'struct cxl_error_handlers *' hanging off 'struct pci_driver' since
accelerator drivers are going to have distinct error handling from
generic memory expanders.

