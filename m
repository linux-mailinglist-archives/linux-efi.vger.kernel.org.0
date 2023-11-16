Return-Path: <linux-efi+bounces-50-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C57ED8AE
	for <lists+linux-efi@lfdr.de>; Thu, 16 Nov 2023 01:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE0F28100B
	for <lists+linux-efi@lfdr.de>; Thu, 16 Nov 2023 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160AECE;
	Thu, 16 Nov 2023 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XMOw63ov";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qu2jEHoc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE93A6;
	Wed, 15 Nov 2023 16:51:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFM8w8O028161;
	Thu, 16 Nov 2023 00:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OQ1Lako3fQIclTrP+S31WAD2AFIIvhQA6kBCuN9O+PY=;
 b=XMOw63ov0EP2GgNyZ7vWQE3imaCsu/c3L7z3cUZ6ada8T2+U2pb8Dr6XCSrIdilPQ0bj
 HmyRwQ0P9EyuOcXjrpePFKPlP7S6SrTfu1VPC8BCvzvuiuy9LO6f5UxBGiQoz3PIVUA8
 9QItun+Pb5Na7ohi1WRSLeS6ImdidDTeg/7H4TiNE9x9wHIuJ5klCG2e297Rl/SD6LEh
 C9q58DH4oXjt7wd/RixbVoMIszARJ21RkyL40qaUJVcOgSQXamLoQsXhEqtNWoCXulNL
 RRMgQIzeS4LpU7TZmeJakeZWmTDPVxRVEhuGkY17kzOcfQCTAx4MwROVgr2DsmBOCdHx Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd9vrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 00:50:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFMbROm038606;
	Thu, 16 Nov 2023 00:50:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k61p1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 00:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHEprXn40AFt4H4HjPrBvDAIzeHSwQU1H6SceTlKMbSrBBOxVMG4pEcGQUzfeWDkILvRc4UQ7CAiwYr0nof6mFm8KP/zmlmWcoPCQ7Czagf/wMAhnd8jHrbWvtHNBGAerqHyslGnCKtx0XF/mIRUaf/FycjTv8ErGVQtJiRsTMba3XtkZNrXo4O2LJj32vpZjp3+rgR0XV1Ja7g5ykRfyl9JW082AGNZw6KO/6y4wzDtz6pauGZ0XPz7cTl2bqernF0LSung0z6ON9eVbyDtB6i6kfABp0rUmZYmqiX7YROK69+BYcGrrRuFWGL/K48ecaY4C06NW4mqqK14N2kWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ1Lako3fQIclTrP+S31WAD2AFIIvhQA6kBCuN9O+PY=;
 b=MrdGjx0bA67eYWCFKFF1dsRPbJftSjoZJH6sOeagmVdyPQveuAbKjI/hyDUdBNCGW/EX5ejBjtkKqHukcGlwpFEqDG+6E1cnJHHSo2vkwd6wShDiMEjAoxFH7gRmC/zTq0tKtw9bi8z7akz6I3MXEnxXJK5Be3BMYtZBhF0rV8Al08KqfkjUuL16eOHta4/GJnwPe2FXzxc9T8/r+R0O9bXZgmGTmnOcd0zZLPPJF9lVCYN2VAoazKOBADVaeKARwuhyzX0rCr7xwfydFGzgEIYdQ+sqlhiIWUp/JzPEepKQVNJfGDBPsi5hL1smUMFSdjPjVtP/xUisYxqR90TpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ1Lako3fQIclTrP+S31WAD2AFIIvhQA6kBCuN9O+PY=;
 b=Qu2jEHocC4wdQD9A7BzFV4xW3anvPwIfWkhj4SnZpdZQleSkrtBdidpsTQ6Y5LBUyox5R1OXeQ4z9Ld+9RlYyUwHHsvAsqM8pXMu89CaUni7v+81AufN7fM8IQINxUJw3gaCTed5iOOjzI20tY6dEaU2rZ2EhimiarLBzHXJ+y4=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BLAPR10MB5281.namprd10.prod.outlook.com (2603:10b6:208:30f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 00:50:30 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37de:88fd:becd:7e3f]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37de:88fd:becd:7e3f%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 00:50:30 +0000
Message-ID: <832911b6-9161-4dd4-86db-8d16e6ffdc94@oracle.com>
Date: Wed, 15 Nov 2023 16:50:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/13] kexec: Secure Launch kexec SEXIT support
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
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
 <20231110222751.219836-11-ross.philipson@oracle.com>
 <ZU6_uUe45qAx52mI@google.com>
From: ross.philipson@oracle.com
In-Reply-To: <ZU6_uUe45qAx52mI@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:a03:331::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|BLAPR10MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a491b0-1d5f-4115-8961-08dbe63e0849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZMNFhX+2BpQHKoY96trBJ5RsMQiGeGLdmX4FhcKTDfFySKeoGXf0Mw0TXxM5sgsSYwCiXf78XsoBW0Mu//Ey1hfF/XsHd0loGtWscix217wYCw9rWs42KOk7WVLnJAZ3DJChE/MBNt3TDTnlw1ZV+DOiNoj7OaJmqiXqLIGX0WNOeFjbB5c6aVKm7zB39znaUPdzelz8tbK/Soqess7uR4AKQOKjI+NCEYdSRoxhpTe+YexUvD8bdFeP1obX1ibfT9a2AkvsMRoi17Hi8eKnVIpYcKztd6G5YDclfgmkJyaaKJJsgrw51GZvmb9E9uRnBh3fBWOK5ZiblZRMuc3GNFkhGMdOJyv72jasjh+4biBk4rHZ3rAA3Ewdc00FNTMMj1Ee/xUlZ/0nFTQocQNBngh9N3g93vsfPo/nfzOpHuE9JMKOr8SRcavrLLJUtV13UV9wKhbHi9yrnACflmliv7sy/1dMPfOxNJmqHCr72xu1Je4nWOApuYZekKZqKTrStxwh1fStQBRYz2y0QBjBhjL7861Kb5MPdopcwk6PXRdWx9wgqy2eQyr4ubiTlow/6UOhGcj2I814ljhjuX5HI2P0920k5iMGoIQzvMOGC0eKdi4phk5WRpcFKDPwgk8J
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(2906002)(38100700002)(5660300002)(86362001)(31696002)(6512007)(9686003)(83380400001)(6506007)(53546011)(7416002)(26005)(2616005)(6486002)(41300700001)(36756003)(478600001)(66946007)(4326008)(66556008)(316002)(8936002)(8676002)(66476007)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2VLZUhiMUNnYzA1NklQMmc3OGlkMGJVODA0MTRZWTVHNG1UV2xtd1g0VUJL?=
 =?utf-8?B?akZHWGMvSWl3UVpjUG5BY0JTbW00TDdnZFYrZlUrVm9ZeHFZcUZpMlhtTDNH?=
 =?utf-8?B?bXpsR3BVZVo1R29hZml0TG8xMTZoaG1uU2tGcFZ5c0Y4ZlUyVGtUMmZJVEox?=
 =?utf-8?B?QkVFNGVjMU1mNzErYkh6eFJ2bmRtbm1nZGhvbno1UjdWYnRZV3ZvTW1VU0NE?=
 =?utf-8?B?dHN5dU16bnIwRlZIZWJ5MHQzSXROR1BzemdXL0hwYXJoeVQ0U2Y0cUlJUGQ1?=
 =?utf-8?B?M1VoVUE5eW9CdHhTTmFQRUNUcjkrcE1hMjZjYS9tenpDOUlZQUcwbzJ4ZitH?=
 =?utf-8?B?aFYrMSttenZDa3FqSm9rT1BjY25qWnZBeWhTK0VGcVEwd1JGLzNiYnZZZHda?=
 =?utf-8?B?b29WYTZhNzFla1ZyeWhPeHBaTnZkd3FyMlJFdDAwZFpwdWJXRUw2ZmNtaVVy?=
 =?utf-8?B?ZXUrSGFZYkNQU2hnMTFEM0hsWUtCcEs3N3hvYlpEeDRQR1F1SGt4S1B0eVBF?=
 =?utf-8?B?VnJ3NTNLb0VxZnRnRDBHTHA2VW9YYVE4MGhOSExhOHR4MlNTM25CUExWOHd3?=
 =?utf-8?B?cVpOa0VuUy9PZU9IN2FBQU11QytXS2pPcUc3Rk5XdWcrU1pQS3NiSXFhVzFZ?=
 =?utf-8?B?NDBHdXBKQVhHbjA2QW0zWlZXU2RPM2ZMbW9qK1BvRFVDZFVSSjRWRFJmRWZu?=
 =?utf-8?B?K0swNEhySmRhRWppL3RQSFNiN3huZFJmWS9ZQ1l1YjBTQm5yZU5oeC9TNmFj?=
 =?utf-8?B?dGVTZHZMbUhESk1zakdJUHNVbUhCTEZpdmxuTHgyMmp0Y3h6cENlMStiYklY?=
 =?utf-8?B?TzcwWE92Y1FFMGZaYStveCtXbDJITTZsdC9WQXFHYi8wTmc2WE5IckhRdkJ0?=
 =?utf-8?B?Q0l2L3JnWURFY0dsUWsrZjlLRXlLNGp2Uzd2RGEvU0FXMWtmcFRJSFZEa0Qz?=
 =?utf-8?B?cUluVndTOWlCajF2ZFdBbUdHaWQ4UjlCNStlY1kxZlEzZ2xGRkt4MURRNm9r?=
 =?utf-8?B?ODYwYS9qN0tROUNJRWhUdkhTdUovTXB4dFA0L3ozdVptc0pZdmpGNWdBeVY5?=
 =?utf-8?B?MmZwUFVFcDBreThkbUVCOHloNjFMN3NOUWhTWnZvS0tXTTl0THZERjF4c3hH?=
 =?utf-8?B?K3F5OG1MeGNxT2RMVEkvVXdTWCttQitabWRQVG9HVkVEU1JrdEtFTU5adE5U?=
 =?utf-8?B?ZVhhaDNSc1FiRUdHL0Z1bDNuUEpuUkgvSnAxK0hBV3Q5TmFIbWhNeTk5YmFT?=
 =?utf-8?B?OGZaSnptUGp4RWR1VE1PMy8ybGpiZ3NWUGtBcUVDYk1rTldXYTBKYk9OR0pT?=
 =?utf-8?B?NU5hdlhmV3hQelYveEplK1hKbDd6ZnU4L3pRL1B5YTZ1WHNMcmJYeXJMN2pU?=
 =?utf-8?B?WjRVZ3E3TFdKK21nSk1SRTVua29RdDdhaC9lREh4anBTKzk1S0FuditxMktW?=
 =?utf-8?B?eTgraFhoZnVXZ2hpVjZRR1I2S09zYUVGeVpmOTJqMEtFY3V2enRRYkFYaWpE?=
 =?utf-8?B?MENrNldwTjd4NnZGUUdjU05SK2R6Zk1jT0Q4eWFQSWdYb3F3TWpRZEY3VDRG?=
 =?utf-8?B?OEx6dE11M3lxOXRvRFpvTDU3L1Z6QjRWOEdTMFpKakgxOEhWazhLdUpVMUcz?=
 =?utf-8?B?cStKQi9DaUQ5UUxJYUJHb2lBaW1id3ZQNmxzU2lIdXJwcU82YVA0K0pJTFdx?=
 =?utf-8?B?UVl4MGZ2Y251NDBBQ2RRTHJ1SitmTmlzSERYVEhmclJxZUNCSVM0RTROWXNx?=
 =?utf-8?B?Mll6Sm95NEZjbHc2TmNVRVVTS2V1TzFRREVvMVFvTDBGTnVhb2FRMWRvVS9T?=
 =?utf-8?B?L2FBSVhkRVlNVEFFaU1mMzl5R05hU0dmN01LcGFXUEpTS1BCcjdrN0pHaGQ1?=
 =?utf-8?B?T29lR09uRDJCQS9RWE9HODZvekZIN01za1VuRTM5WGVPVW9za0tMN0RISnhR?=
 =?utf-8?B?UWYyOUJZb3c5UTVMQWtlSmdJTVBnZFVkOTdhZWNwRlNkcVBucy9qUjVhaVlO?=
 =?utf-8?B?ODFsd3dzM1RRZmt5bXMyOEtLblJZOTc1YSt0VVJIL1VhbTExWDhXdXFoSWtx?=
 =?utf-8?B?VFhBTmR3QWY0dmpqWHFjbXVYUUxrMzRuZ05Vcm5MM1VteFY0ZzN6U3FnS0VZ?=
 =?utf-8?B?VlNxVnBwUldMNHhDRThqWXhFQVFqMko4TXhyRHZzZGZ5VU9USjRmRWNWZFNP?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?bDhxbVI0ajZzKzBMUUt2UXRXbFBPZ0ZnTlJoYmxFK1ZhRUw0QmdaY1QzZ2xB?=
 =?utf-8?B?MSszWHZtUDlVaWQrU09xbFF2ZWJXVmxSMGJLcyswdktUVVAwcGZob3dPZUM5?=
 =?utf-8?B?L0JMYXc3bzZMMDJQcDBSc3ZhSmhjeS9qWWRaUXhWK3Z6YW5IcTZqS3N5U3Bz?=
 =?utf-8?B?OVNrL1RUSzlhaWVJLzZ2Yko3U2FXWjZ6NTNvUDlqL2tZblFieGRIU1hhUGJH?=
 =?utf-8?B?b3BFYkQ4QUVCblB3QnFUblhJdDJBNytDTjU2L2NoSjNiV3lKdjYxUkFha2hE?=
 =?utf-8?B?Nkc5US9tb3kyT2ZtUHEyZW52RHhoVWhpV0g0UGJFb2loR05aMi9kTkszV2Fw?=
 =?utf-8?B?cGNyS2ZIdDVHRFpiUlNtOCtGTEFTNk9xWW16MVBwL0h5OXQrTTBqNHJTUXBj?=
 =?utf-8?B?T0lYWVZxUytvVnBjYjBXaW5wU3hoRUFKVlYzbUxidk1acTRBNVd2Z0xBbDhT?=
 =?utf-8?B?WDBXWnhTczhOQUI0ek9CbHgzYjA5VmVNeFpDM0QyREVYUkRaUzBGNmJOMUpv?=
 =?utf-8?B?SGJyeEE1bzZxWkx2UmZhZ1hJUTFWS0RWRGNXRFZxVm9UTmtpTFc3ZGZDTmhy?=
 =?utf-8?B?MjU4KzJIbmVyT2FJdEVFOFhibVU4UmFEY2k5QzkrVWpWUXIyUE55VmhKelRs?=
 =?utf-8?B?TGpQVXBySkVyNFNlWUhhOFBwdmpXN1k2WktPVXNubFVLcENIWjlQT0ZWemgr?=
 =?utf-8?B?WmVib282S1NWKytTTmdLQTdrbXF4S3JnbncwcW1IVis3T00zWVFBcloveDV0?=
 =?utf-8?B?V1VSZC9jaGRIK2ZTWlU3MllYRTR0aWtaUi91emdXV3VGYXg5cGFPMXphSy9H?=
 =?utf-8?B?UVkwdFFoWWdweTdWYktZWXRRTUtOU283b25MamZFNmRzMDllSWtpNDhvNUxL?=
 =?utf-8?B?MVVVRnNXNVo3NDJqa0JFdWlRMFlYd3BKczhIcTEzNTlaRXg4dHB1dWZGVTg0?=
 =?utf-8?B?ZWNqOWUwK1h1a0RDcTdYS1lRaUF5ZEg5elEwRkV0Y3k3UVB1Y0FKWjFubDNT?=
 =?utf-8?B?Rm9TZWxWSmNrdFFndm5wMEZuR0xKNXRpSHQrV0Jia1Z5eE5RdUI2NzlCUlVC?=
 =?utf-8?B?YzExVzZTZ2ltWUU1d0dyWHdRYnlLVk1WenIzcWJjdVlIcThaNzREeE9aUi9h?=
 =?utf-8?B?Rjc3dmhXSHpXMDh0b2JIaFNhaS9tVkVtSUZ4cTBrYkRlVTh1TEN2YXA0TWVX?=
 =?utf-8?B?Q3p6aTlFc2RDTnd2emt4Zm9meGhpQ2FOYnhONlQrTnVKUEJYSk92Sndpc3lz?=
 =?utf-8?B?akE0Y2NXR1VZZDlGZk1CcmhhWDdiZUllbXp2NUlBb3pVWVJQd0dReCtwSzl5?=
 =?utf-8?B?clVJN1JoL2U2akhNQjFEQXl3K3NTTmFobDVvdE9FcUJaVVk0MEl4SzIzVkhH?=
 =?utf-8?B?K01zY2lGYkhFVHh3RU5tMXFPYkpaZGlmMjdnM3ZnS1JPdnZ3aE5vU2FOeWVE?=
 =?utf-8?B?ZUNFZC9rT3lISHkwbGhpNzdmZ2NHVHNLMVRsd2JVaTlGckV2M3FBdm9temp6?=
 =?utf-8?B?SUNzK28wTERUMkRhZDkxcldYU3I3Zk1GZ1JYMWtpWGlsVk5rS2FvMzdvNjJn?=
 =?utf-8?B?ZG1PeXROYXNhckxQeDFURmllcTM4STVGaVZ2eExicmNDRyt5UVZwcVFkQ2dC?=
 =?utf-8?B?NnIwcUdSbktuSFZvRGprRGd3alR5Q3VLcGZRRFNTMWtac1hFNkM1a0VoRGg1?=
 =?utf-8?B?NHRYMTZXdzJNV0NoS2drTWJsRTRnTHp4ams3Zzhqeldoa0JDWkhnYmNKN0cz?=
 =?utf-8?B?L1lsUmdOaDdlUjZzWDlkL041Q09xMnlVdzJ5N0E3cHkvaEJFZmoyd1I1a1p6?=
 =?utf-8?B?ODNQSkkwQ01aNmF2dE9BUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a491b0-1d5f-4115-8961-08dbe63e0849
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 00:50:30.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EK2IoJwFQlNtTjvCm+xbVLPHAcKXY6W7O1XE51/2JXqpNCYx1eM6YXpyiW5ybxOuBEP63Ncqrh0FagPjjIhQbyoNRtdV0BXmRTuC3E0YBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160005
X-Proofpoint-ORIG-GUID: sCvnIfbJSSl_3m30HH2Y25TXwXlzNY78
X-Proofpoint-GUID: sCvnIfbJSSl_3m30HH2Y25TXwXlzNY78

On 11/10/23 3:41 PM, Sean Christopherson wrote:
> On Fri, Nov 10, 2023, Ross Philipson wrote:
>> Prior to running the next kernel via kexec, the Secure Launch code
>> closes down private SMX resources and does an SEXIT. This allows the
>> next kernel to start normally without any issues starting the APs etc.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/kernel/slaunch.c | 73 +++++++++++++++++++++++++++++++++++++++
>>   kernel/kexec_core.c       |  4 +++
>>   2 files changed, 77 insertions(+)
>>
>> diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
>> index cd5aa34e395c..32b0c24a6484 100644
>> --- a/arch/x86/kernel/slaunch.c
>> +++ b/arch/x86/kernel/slaunch.c
>> @@ -523,3 +523,76 @@ void __init slaunch_setup_txt(void)
>>   
>>   	pr_info("Intel TXT setup complete\n");
>>   }
>> +
>> +static inline void smx_getsec_sexit(void)
>> +{
>> +	asm volatile (".byte 0x0f,0x37\n"
>> +		      : : "a" (SMX_X86_GETSEC_SEXIT));
> 
> SMX has been around for what, two decades?  Is open coding getsec actually necessary?

There were some older gcc compilers that still did not like the getsec 
mnemonic. Perhaps they are old enough now where they don't matter any 
longer. I will check on that...

> 
>> +	/* Disable SMX mode */
> 
> Heh, the code and the comment don't really agree.  I'm guessing the intent of the
> comment is referring to leaving the measured environment, but it looks odd.   If
> manually setting SMXE is necessary, I'd just delete this comment, or maybe move
> it to above SEXIT.

I will look it over and see what makes sense.

> 
>> +	cr4_set_bits(X86_CR4_SMXE);
> 
> Is it actually legal to clear CR4.SMXE while post-SENTER?  I don't see anything
> in the SDM that says it's illegal, but allowing software to clear SMXE in that
> case seems all kinds of odd.

I am pretty sure I coded this up using the pseudo code in the TXT dev 
guide and some guidance from Intel/former Intel folks. I will revisit it 
to make sure it is correct.

Thanks
Ross

> 
>> +
>> +	/* Do the SEXIT SMX operation */
>> +	smx_getsec_sexit();
>> +
>> +	pr_info("TXT SEXIT complete.\n");
>> +}


