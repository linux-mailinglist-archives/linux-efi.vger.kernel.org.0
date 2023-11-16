Return-Path: <linux-efi+bounces-51-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C427EE63D
	for <lists+linux-efi@lfdr.de>; Thu, 16 Nov 2023 18:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B4B20C53
	for <lists+linux-efi@lfdr.de>; Thu, 16 Nov 2023 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8634146546;
	Thu, 16 Nov 2023 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vzH9jCb2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wrh+Wijz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C46189;
	Thu, 16 Nov 2023 09:56:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHi28t005380;
	Thu, 16 Nov 2023 17:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mH7PwsriJEN60Wkfoa5wsKCXMcqvnnG23vrj+arswvQ=;
 b=vzH9jCb2nZilWH2DauVkaZXM9Sz3O7VkGG+9hl/6rcgbIqUUi1vVl17y3eGz67hWpZ2F
 wem2BrWYm7QzpNEk5h4fGzQolfunlrUgGAp+piZo0AqAq+IkaLknc13sCLVKx/aToezn
 /w+rY0VyeA25FU++nVwPa9RA6yhTni80ejTPb0ZMt6QjTZp4oQ1aOmtoKFKsJazB5Gt+
 Ijgf53/HotRMlSa1isMsUwQg/lwWV7fCN5AgSe/qzn/Ntw7cR5oFttCVgdFyLl4WTqoD
 A93tQcPpELYfojZF2GLNRbT9rZkPANlEu/z8eZPy1tGCzdUDxftGZcdaqa8WmmFwLGc2 Cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qdbk13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 17:55:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHsNbF038411;
	Thu, 16 Nov 2023 17:55:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq10fyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 17:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzyWyNyVeHacguEvqVLO4dqcnB5e0ar4gAhsPoUixfaon4vLP1hBMj4NYmHHzasqb3JWAb1Sd+D2aApB9FJ5uTxMXuFDsr7wa5//zRILna1jYc5yEHo//WGRvEFu/OV8fjOKkGMu1OOcBE3COg0475vkaGx6i0we2ZQUfVAtJEpwnqgMzevxA/+svsesQKbtZ/xfaj6NHuFXVlvTuFdDX+jVuC6UkMq7+tM/y92TNp2dLIPyRz+UPUKmasfdozOE8BDaaov9tbXNzqO/jCGjivOaeFYZspNM+JBsvMy9ZIyYIx/XY3TSO6Zi3jFM1vZILziC0AwAskPLZBwupeB8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH7PwsriJEN60Wkfoa5wsKCXMcqvnnG23vrj+arswvQ=;
 b=BAZC4UlIcCq7kkxxqXWZRNOVPNN1ra+I+hX769WIdVJ8K6R9oUCscxP0D19jYWe5AGRIGE6U+V6DJ9YKobuI1IghCkh+kCEjoCIMVR8jbmxFEEn8RPFticXdymA4dGMqJQjqdqRhrKBsH8mqy21BJo7LUyQcf0Jwmo6NIBhMbA62jETKc2XcLfKTNSvtYdUwIMvhkyDX4Qiss0Rc1w239RTnhrQunXSYl5g5QXRFGOWzja+VQnGr/vtI2U3YmFTV/JqStiGAw9ew+emewuATlo3O/8i7pPWt5ILR8H5Kpbm6rdfId+IGGPzM0RwrQoxQyvDvRH5DxTQXWSFAidi1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH7PwsriJEN60Wkfoa5wsKCXMcqvnnG23vrj+arswvQ=;
 b=Wrh+WijzL/ZtD6wOVC3i5SD0BwGJ1XZKMpI9k1MRL5vX5JZD7CNpGinhg2zcZJRV5J/S3kv/YN9nEmY3rwdsUQjyvQacBv/XQ2kM4HixpTGvxkKKPb60a5GaJs4ir5shKeNk++wfLMe3/Ya4odZips8Nos9PvXCmjcvWTBlHLE8=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 17:55:47 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37de:88fd:becd:7e3f]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37de:88fd:becd:7e3f%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 17:55:47 +0000
Message-ID: <f9360f2d-ad2d-4f06-bf01-85b2630cd237@oracle.com>
Date: Thu, 16 Nov 2023 09:55:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/13] Documentation/x86: Secure Launch kernel
 documentation
To: Alyssa Ross <hi@alyssa.is>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-3-ross.philipson@oracle.com>
 <scpu273f2mprr2uvjlyk2xrjjtcduhse2eb45lmj7givn6jh4u@i2v4f2vbldu4>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <scpu273f2mprr2uvjlyk2xrjjtcduhse2eb45lmj7givn6jh4u@i2v4f2vbldu4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::6) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d373ba4-e543-4709-b630-08dbe6cd4272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bk/1e695liSWubryden5/tfRS0FF27eGl+q0O/7+4J0zi76GKQV/jKyDgGECwtaTWwTWKvQXiIfO6gBis/KD6ikRsaSdIN2tPc8gXkGZYSIywX9TleiQwSJxO8Tseuqpu6Czr+Qh9hKRB2k4ebbeeq6GCHOjlgKL1FOpsB+x5HrThN4jk9eBYgNXB4ZU/MsQYR+Brds3xS3eqGocWYZ1d7P1kqT6RNxVj8IErfWm3d9rE5CVg/SKq+OlEg4YffaLCj+3LjsCacRY4YODnLWCWxS+3RcG/Gk9qSWZh4pLZ1526absyol2lqODolCbDA/AmSfBulJBc9WCs1zhPwIo3yZiwiGNIF/Vx2kn8M5clLZFBR9VH4s+bzFeWSrn7kN282+8lbMoEpSAvW/Fcmt9xsWAJDJihOSStjlnB+4PnBltWdm/cKnMrOdfgMR+uwyEtU2YI4C1AtU1OR2bsComMuLVemi675EUWNthc3BsMZLV+S7msISdgkAvF7DOsK9KFzm39A1FyKSbrFJ47XIKCq0c28xJiwOJl5OGSVezkWGLhytqQVFCybslYrCSQWfggFvZ2Fk9CQvd4/xIL1kYFD4M2ZSPL6AsBLWDybEYm4WlpeFD8EE5Y07+ZG+52k759r3fIBT9j7AtJ7vfOt2AFfJthEXrtKBINIkV7AH+LlQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(31686004)(31696002)(86362001)(6486002)(9686003)(478600001)(66946007)(66556008)(6512007)(6666004)(66476007)(6916009)(316002)(6506007)(53546011)(4326008)(8936002)(8676002)(26005)(2616005)(2906002)(83380400001)(7416002)(5660300002)(41300700001)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RXdtUjFtWXVSWUp0QkNPSTQ5c0I4RUpKUG0rTml5UTJVNzhqUW44cWUxV2lF?=
 =?utf-8?B?YkVyN0VxMVoyUUxxcm1ZWW4rWTR1azg0VHRXcGJkMSs4OUZrVVY3clh1a1hn?=
 =?utf-8?B?WUVQL2hWSURZbmN4VEFBbFp2TFZTOXZqRDBCSDRNMG1FMElGMnducWRSSHNG?=
 =?utf-8?B?aUYxcER6ZEJYY2FOTysyb09DaTIwaXZnQXVxNXNYemgxWUloSDl4alJjSEpC?=
 =?utf-8?B?eUxjQm1VVmxNMDVnL1dsbDNlc3l0VjdGcC83RlJkWEIxaUEyNzU0Tk9URnV2?=
 =?utf-8?B?aExmak5abEp6YmwzT2lXc2RES2xTb2pvMXA4dkg2UkRqcEV4TmplUzhFTkRQ?=
 =?utf-8?B?dTZ6bUpoMldHcmFlQlJmRXdZNzAwQ29jUDhvT3A2L1IwNjlQajMwRzltNWgr?=
 =?utf-8?B?eEFoOUs0TGh0cHA2cUMvbUxCQTJhdmZJQXhBRUNlM3B3b1FIK1dld3I4azRl?=
 =?utf-8?B?WDUwYTcyRDdERVpsZDNzSElZb0w3N3lvT2FVNDhmVVQ4NFFCZENpbzhxa3BL?=
 =?utf-8?B?a3A3T292UzB6S3hSdVJ3SXJISUNnRkQ2WUc4Q0VMek5HUkMzVTVkS2x3UU42?=
 =?utf-8?B?bXREM09TUUNLTk1WNnRZN1c3Zjgrem9ZT1RvTWJ4SHdQL2tvM3VhUWZGaXJL?=
 =?utf-8?B?NlhkMHgwZWh3ODdoWXhJdjU2VlRqeUJwRnBabWVLemJITWRpcjJ1cGhMbGQy?=
 =?utf-8?B?ai9Xbkh1ZHNDNklEekFZcElvYVZsS0t2clFWMnY3QnpTVFRISW1BcWhzL2du?=
 =?utf-8?B?TlQ1Z1dZU25Lc3VFeEsyNjEydmNwaVkwb3N2WkQ2TkdvYTJ2Tlgvbis0MFZ4?=
 =?utf-8?B?UVB0NGEvRnRsWm9Kell0Uy9YOFN2cllwR3FBMzVXU3VOZytLTklRbXJScWZn?=
 =?utf-8?B?cWJSUEJ0TktMTnVwdHhPcmFBU0hxbVBCMkdVUm1BTGJ4L25LVFlyNkFMWGox?=
 =?utf-8?B?Qkl5T3JvQW1VbW1hL2FHTjdabmFuZGZSKytyVnRzMUNxTm9kZmxuenh5MnU4?=
 =?utf-8?B?QlQ5cEFGV3A3a3Q2aXBsZjc5OGNTeUJYNmxQQ1BaRkE3RWRYVVc5NkRiUnkv?=
 =?utf-8?B?d1VmT0VpeXg4elJKeEdGbFBWaVNlc3dFRWFjcEVBaXQyNHJEYVg0R0x5NWUy?=
 =?utf-8?B?R21LclJiRFFvZ2NUMGNMM1BXZzFmUXRBM1RTdFhFQzViWEZXRmVzb29ZaFJO?=
 =?utf-8?B?TWt4UkU0TGFJSkxhaWE5QU1iQm9pMXExaVdNOE1rdFF5NWJwT0dGTDIrSGtL?=
 =?utf-8?B?VzNDcHBKaC9kUytuOTlsa1MzdzVpNUlSNEFKd2l4dndCVExkWWxoeFFTOTl1?=
 =?utf-8?B?VjJRaTV0aGdCUDFvbGdCVW94MjZ2Yk90a01hKzhweTkwQXh2Und2eUpLRitt?=
 =?utf-8?B?eUFZcE5wOC9pNXJQbENVUTk2K2ZURERiaGxHdEwxa2lrbFVISksvbWVlMGRu?=
 =?utf-8?B?b1pObkVNTVQ5cGt0UTZ5QlBZNXZ0V2owY1plbmRaQUppTHlzTFoyYlQxR1Rr?=
 =?utf-8?B?ODl1VkVoNEJPSWhxOFY2SncvY01lU2ExbGFDZXBrNGFBUndjMDBvOXFRdUhv?=
 =?utf-8?B?SE5YWDA4UXd4R1hGT3F5Q2JxcTFLNUExd3I3V1R5d29Zelk5UGRpUTlEa2Ri?=
 =?utf-8?B?M2xDT3ZOMnZBa0owVGw4K0ZkVkRQaTIrSk1xT1BJY2Vuem93a2I2M3NRZjRM?=
 =?utf-8?B?MlIraU0wcHR1WEtpbUF4S0hYN1VocEVJRHUzeDZvblBEcVRmUUR5K1VkYjkw?=
 =?utf-8?B?NHNrVlBTTkkvZ0EwaGxCVmhYeXB6STA3UW5iWlF6ZkpPT29BMDlHOTV1SmdW?=
 =?utf-8?B?dm5PVFN2Q2lQclhkWUpPRkVHZ1AzRzJDRXI5UWdrTzgzSlhwbVhkSlplK2Ez?=
 =?utf-8?B?VWdTSmZKSFNyelhKNXNsaGo5ZXQyLzgvSHcwUlJleVY2c2xwbVpLMWhaSEV6?=
 =?utf-8?B?cG5rcFdLZG9yMHp0VzV4cVBCSkdGdFdyWG9iNkp6Ti9UMHRPSlJHemVQK2Rh?=
 =?utf-8?B?S0pmWnhtU1JsckZ2eSs0eDcrcFNOT1E2M21VaWNsWndvaWFkcU84RWFZKy9G?=
 =?utf-8?B?cEI4ZzBXNHE2WjhVUTR6RDhDbXduVWN0K2dPaG1ZSFIvQ2cvUE9IengyK1I0?=
 =?utf-8?B?V05qbHJEeUR6RmdIU2twVzVtYnVTN3RBTXpsMVU4ODE1ZHlQdnI5RzAvUUQ4?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?TXlLMDRvTy9RdDQ2WnowdElKai83bEhvY0NZajh5ZXU2WXQ5bHhLM2NIKzh2?=
 =?utf-8?B?eFBsYk5sKzBCQ3ZNbDNLUDJUdzRJZkZ6TXlzYVNYS0YycXVMU09UakVaTVpr?=
 =?utf-8?B?cnBwRkVvZVJsVXBtbk13UGw5WTJBWDRNQUhFQ0hUK01ub0Q1ZFhJNU1pZzVH?=
 =?utf-8?B?c3A1UkE1ajh4d1VKU3JiamRobGNWQmdMODZQYzhzd3NOVWE0emhtSmhaSjBs?=
 =?utf-8?B?N3pEVWRJYTMwcGFVdnVVNlVkbjFJS3dDcmhWMTBuOExIOHR5NmRlbDQ3Tnkx?=
 =?utf-8?B?bWcrTnUyd2lGVU5UNUhwSGRIWkJxaGZyR2x3QWxjOWFmWFlaSU1KaEJPUStC?=
 =?utf-8?B?b1JvVEsxOWxuQUd1WnhFMzlBUVIxUnA4SDAyOW9iMmp4WTBMUjh0TndsbmRr?=
 =?utf-8?B?VXI3ZDA0dDNMTmdpRFZTRFY2THFMRzloRG4rUllFMXVmR29NUndVOEFVanJq?=
 =?utf-8?B?OHJYUlp4S2ttTktMZDBBUUNwM0ZvOGpBNjNMckFlMk9mbXNOT0tBZ2ZYUVFE?=
 =?utf-8?B?bmpDelFYTE5seS92d1NEYldLa0F1WnE5NEVkaEF5b0dWVXVPaTBqd3pVVndl?=
 =?utf-8?B?a1B6WFdnRjZmNlhGbS9lamc3dlNBTGtUNmxHSHJFeWpoUW5VRnFFTVRmK3ov?=
 =?utf-8?B?UHp6YlBTU1U4ZS9mazI0ekJJbndOOWNENUxIUlJWVmR6ZTQwb1VjNHdUVTk3?=
 =?utf-8?B?c1lrR3MxNFRxb3NCMVNTMDJQbjg0Um1vZm03YVphVXQ1Nlo3eElJM1Q2Sk9X?=
 =?utf-8?B?MWVKUGVXcUZyd04rTWx0UTl0L3BKYVRPaGR6SFV4eW1IVThlOTBMTTlOQ0Jk?=
 =?utf-8?B?MmZhU0tnMHJoTnA1anE0QXFuRmlJZE50VlJSWUE4UlNLZThQWENmRVBYQVV1?=
 =?utf-8?B?WDVyU0JUc3Jab0sySS9xdlZpdmc4NVV3UHNSQ1JDWHJCWUxmTEFjZmNTRUJv?=
 =?utf-8?B?MjZYY2puUkM1YU1jS1RjU1BremVCM0dOTUVlaGFFNndLdWxxbzgxRjF1ZnFK?=
 =?utf-8?B?TExiSTBGSlNMSDFtZWV4YXd1RUZBbEl1SGo1dEJoMUM1cXRiQjBwQldKZmJJ?=
 =?utf-8?B?dmhaUzMrcytFRjRXSVRldmNCakF6cEN0QUlLOG53N2JnR3FpZFNyS3ljZDF4?=
 =?utf-8?B?LzNRSHMyRmN0eVA5RGZlcDdiNHo3a2x3UXU0NTI2V3lzSklza1FuYmtBZjY5?=
 =?utf-8?B?OXdWQnZoL25XLzlWWEpYMEZvYkZ3amN4UlpQNW5hZUZPNTNJQk5tRCtrQlUz?=
 =?utf-8?B?cmZlN1NOZkYxczdYYTI0NWZIWkl5aTBDV2MwRDhDeVJBOG1VYmNpZEc3Zy9K?=
 =?utf-8?B?V3g5Y0M2SGpualhOZXYrdXhXemg5VG9jRkNXVi82VlprSSs5OU5xVkEwb3Jt?=
 =?utf-8?B?VzNXR0hjMEhxdmVldC9KUmpUcmJlL0hHTkl0TnNwR3Z4RWhzNk5OdTlldjN1?=
 =?utf-8?B?ZXpZQ3k5c1NTNlk4T2dyZmh5cHJaY1RkQitOUy9vTzhmYS9WdkFOSEF4NnF3?=
 =?utf-8?B?K3FWVXpvY3BkR2FqYTRMbVFDRXg4WDE4eUdXcFpESVNFbU9DM0FuQ3Q3Qits?=
 =?utf-8?B?cHN3ZzNSMTBoOW4rRFp0SkxZY2NXUHdGcDl1RWEya2xlaTU0NUZxcnNJR3Ry?=
 =?utf-8?B?c3ArT3VyQnVXakVJOXY5OVpnTnBDTVlNSDFIeXcwOUJlSU9UclJJcm93Z2I0?=
 =?utf-8?B?YzRNeFByVE8wSUFzWUMvVmpCODd2aFZNMVJWT05qZFZldXNqc284U012T3NO?=
 =?utf-8?B?Q0RwWFFjVEhiSXlxaElPMlJZS1RLeDJPNHIyZVNIZ25WVDUvaUxCazZ0bFUv?=
 =?utf-8?B?VEZpRWtaNGFxQ2dUbkc0QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d373ba4-e543-4709-b630-08dbe6cd4272
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:55:46.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQZEfYB4oKdkOy0ugUVcM13N1m1Q5t8PVgiqfaSK8DLGmaFPL9adiQzsCE779Xr/77IVRU+zBbH34HPjNs/de9HUaDAJMwAT1kAIS2RjmOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_19,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160141
X-Proofpoint-ORIG-GUID: yKGFYHt22MuYq_Za1nipAg2Dace2of0y
X-Proofpoint-GUID: yKGFYHt22MuYq_Za1nipAg2Dace2of0y

On 11/12/23 10:07 AM, Alyssa Ross wrote:
>> +Load-time Integrity
>> +-------------------
>> +
>> +It is critical to understand what load-time integrity establishes about a
>> +system and what is assumed, i.e. what is being trusted. Load-time integrity is
>> +when a trusted entity, i.e. an entity with an assumed integrity, takes an
>> +action to assess an entity being loaded into memory before it is used. A
>> +variety of mechanisms may be used to conduct the assessment, each with
>> +different properties. A particular property is whether the mechanism creates an
>> +evidence of the assessment. Often either cryptographic signature checking or
>> +hashing are the common assessment operations used.
>> +
>> +A signature checking assessment functions by requiring a representation of the
>> +accepted authorities and uses those representations to assess if the entity has
>> +been signed by an accepted authority. The benefit to this process is that
>> +assessment process includes an adjudication of the assessment. The drawbacks
>> +are that 1) the adjudication is susceptible to tampering by the Trusted
>> +Computing Base (TCB), 2) there is no evidence to assert that an untampered
>> +adjudication was completed, and 3) the system must be an active participant in
>> +the key management infrastructure.
>> +
>> +A cryptographic hashing assessment does not adjudicate the assessment but
>> +instead, generates evidence of the assessment to be adjudicated independently.
>> +The benefits to this approach is that the assessment may be simple such that it
>> +may be implemented in an immutable mechanism, e.g. in hardware.  Additionally,
>> +it is possible for the adjudication to be conducted where it cannot be tampered
>> +with by the TCB. The drawback is that a compromised environment will be allowed
>> +to execute until an adjudication can be completed.
>> +
>> +Ultimately, load-time integrity provides confidence that the correct entity was
>> +loaded and in the absence of a run-time integrity mechanism assumes, i.e.
>> +trusts, that the entity will never become corrupted.
> 
> I'm somewhat familiar with this area, but not massively (so probably the
> sort of person this documentation is aimed at!), and this was the only
> section of the documentation I had trouble understanding.
> 
> The thing that confused me was that the first time I read this, I was
> thinking that a hashing assessment would be comparing the generated hash
> to a baked-in known good hash, simliar to how e.g. a verity root hash
> might be specified on the kernel command line, baked in to the OS image.
> This made me wonder why it wasn't considered to be adjudicated during
> assessment.  Upon reading it a second time, I now understand that what
> it's actually talking about is generating a hash, but not comparing it
> automatically against anything, and making it available for external
> adjudication somehow.

Yes there is nothing baked into an image in the way we currently use is. 
I take what you call a hashing assessment to be what we would call 
remote attestation where an independent agent assesses the state of the 
measured launch. This is indeed one of the primary use cases. There is 
another use case closer to the baked in one where secrets on the system 
are sealed to the TPM using a known good PCR configuration. Only by 
launching and attaining that known good state can the secrets be unsealed.

> 
> I don't know if the approach I first thought of is used in early boot
> at all, but it might be worth contrasting the cryptographic hashing
> assessment described here with it, because I imagine that I'm not going
> to be the only reader who's more used to thinking about integrity
> slightly later in the boot process where adjudicating based on a static
> hash is common, and who's mind is going to go to that when they read
> about a "cryptographic hashing assessment".
> 
> The rest of the documentation was easy to understand and very helpful to
> understanding system launch integrity.  Thanks!

I am glad it was helpful. We will revisit the section that caused 
confusion and see if we can make it clearer.

Thank you,
Ross

