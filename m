Return-Path: <linux-efi+bounces-2881-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8453EA4EE2C
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3CF7A1CA1
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7D77102;
	Tue,  4 Mar 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hzZRunzN"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE32E3377;
	Tue,  4 Mar 2025 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119405; cv=fail; b=XCMPLGjkjJw7NBgymhA1biC/lcRE2aYOx1o/UGC+eIKmUV9PHENQ5f6Am62sg+3Oc60j+VoFscMqhWhPwRV+1GJLiHKa2VO5eF9C8yQyTK9MGjvy1mbR1tgws4cYDusev3+SScDnFy6Z+j32TDz7K2mr0NDXvC2ZasKNbZg6i6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119405; c=relaxed/simple;
	bh=mff4U/gP7vwdnRv5CO+WfRRfq/VSMOBGPY1a7UgD+Zk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BGmj5VpCOLHYoTF/zpUELuAwfImZBwen3JW7etwpbQl+Y1iSOZmTa80I1RvOmwPhPgD7fOLcJnVDPh55NdWgpuSgQ5U52S3EjhVZBme0rcpSvK6Cw9rcZB4dUf/La7/dAUMVdmuxnWcsGwJyWqbszH4geMf005sdpQcCX7Y7N+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hzZRunzN; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6P5+YheZl1+/eephj7sYQ/5O6RPTzj/2RWwcmEg4B65R1tLvTGwXMeW1wI2/GO+ti7gjEHs0og1MPUlmCEpnrgHIoKl+viaZkPQPgjFvDVbnzQFvul0BUlRWXZCysMAZnKUdggdc6Hpa6N222dS374qTruM5IxwcoarbtEhGOlQYF2OAZmbMAq2ZizeG1B8UGVtpsVaJtdsIjAKP9JHbXg5Rq+HiIZ9l6UIBJKlhZkAvyv9ekPZwpJb9C5HPUaIBY9RQ991r8F9dZNMQPZlJrMfiPCicVFORFa4aQDETm5167cvemLs9TfYCGjNWs0QqkKwtuCOUHn5No5A5pxHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjmA1PidkiQg7rr9vgM5kU2MJV3i4ceJAQ2ElpKbIwc=;
 b=okTYQIPobeGm8NBr89xluX7Qvl9rKnrvTPfOBdX+2UwaZmC2n8klOvXDDxjq5BWfoBgCYxwFYTuriAu916PaFYGEGoF7kWZui1AvTjuWD2cLvG26D/0eHX0/9Hn7P1xF41ECA6KZ8074JSSWX36brDX+++QR8MTid/bkxLdyXKbMiVn9PcpbaCyrPUnlQXVjUkGguqOcbuaJeCTSKQq94/rU5aXyXtX1TM3tSdhDu/cqunweRBHD/t0bbim+jHGJsXwPUHxaop8v0uqerndAeNLOAaCKrNnUJiwr1I9gaRS4pr4eIawq9bpiOWtIvhDTUXCBeouX26Mqf0v2tbtFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjmA1PidkiQg7rr9vgM5kU2MJV3i4ceJAQ2ElpKbIwc=;
 b=hzZRunzNE/WTw2waRpEf7nDPF/tiNa4GaN4niK0RKjTonKi5eN4Hxfm8QIoE3+tbI6ttQb2iCv7HwWP6G+nA2+U/gq3kaNT+VbHSnhz9k/2diiUHLG72BtB1dO624ktEsGH0SNNAE3e2G4wV9nmZy/LbWqLD4mLyDP723alLmO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 20:16:39 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 20:16:37 +0000
Message-ID: <336ccf36-c0ea-4633-aa26-b683b294f893@amd.com>
Date: Tue, 4 Mar 2025 12:16:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-2-Smita.KoralahalliChannabasappa@amd.com>
 <20250304195731.GA1960804@yaz-khff2.amd.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250304195731.GA1960804@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::22) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 605e8890-9267-4356-f422-08dd5b5977c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTRCQ3VLWDJ1dU1KNG9ZcHI5L1ZaVTdYTEZtSUVUbm1oWkVwZUFQTFBZQXFG?=
 =?utf-8?B?cU1IdVRaSXJ2ZmhBQ3NnYUhSelhPMWI0Y0FrNDNHZXdZNEVLWk9PQ01ZcjQ0?=
 =?utf-8?B?WGlORnc0Vm1aVG5xSGxROXk3ZGdHUFJYV1F5RGZWSlRZUGpycGlHbWJFdUk0?=
 =?utf-8?B?U1VRMFBPZU5ZWUQ0RklNTzRsN1NPRkMvdWl2a2FoVFFXTTh5WUpDclkycGhW?=
 =?utf-8?B?cnV1cnBXWHlHanJXTHg4UXhuYnpESEtoMFJBV29yY0RiR3JaUEEyQkdCR0ps?=
 =?utf-8?B?Tmh3b0w1cmFHT2dsV3Byb2Uwc0ZFWmkydy9MNDl5OWw3UTU5dC8yYWVXdlla?=
 =?utf-8?B?dUl2ay9DV0RGVWJlSTVtbStsVHQ2OXdlcGhZZmtHWWY3b3pHNU9uekNqVXVj?=
 =?utf-8?B?WTl5UjZOcGlDM3k4TEp3OGxhK3A3QUVpeWh0TzZwZzNjNG1mejZMNUo0OEVL?=
 =?utf-8?B?azQyRUR2elZONUhPWG04WUtkZ3Z1YTEyZ0NXMytHei9GYkI1Q1grUWFQOXVr?=
 =?utf-8?B?bnVJUW5pVFRma2Q5dGF6ZDdGeWJlTlhXWW4zMTFsTjZMdUs4b3h5bWdxMnlQ?=
 =?utf-8?B?YnBjTWpjTU9MdVdTUDdRTTRtMThjbkk1WmdoMzByZ25KZ0o1N0wrblE4YUJS?=
 =?utf-8?B?OHl2Mmtudi9XZFRqS0dJZk5sSlpNbzZPc2xIclY3VUNISmRqbkhXZjFwa0JO?=
 =?utf-8?B?RFdnNDR2VllLNjhrNG9BbnJKSm9Bb1F0U2hidElYdmJJcnBtM3UzSXZFUUtv?=
 =?utf-8?B?azNmaHZyNW1oV2Rod3c0S3V2VXMwejAzSytUUnZaZGRHVXI5TVJxNHlMRHJF?=
 =?utf-8?B?NUhQalgycXBYQU1ERWlINlV3Y3dTZThpUlpBRENIc2t3V1gwSFpXdEQrRGdI?=
 =?utf-8?B?bjZ6TEdMcklPL2F2aUkxM1VyN0UyMWxIbnpRMHIxb0tBeUM3TUhUWkVFZ1BO?=
 =?utf-8?B?N01GeGtzL0dPOFp6OC9KenpneXVRdm92eElxTDFxTVpPS1JuSzhaajl1OGJZ?=
 =?utf-8?B?TU1VSnUwWVN5bHE5L0MrU2ptUWtURkgybVNMQnlwWEFxa3I5UVJnU1JhUUFn?=
 =?utf-8?B?d2tXandvdnVIVjdRMERpV3crWXJ4SlRaK0xvTmJQOTdWSlE5ajlWMWdwbndP?=
 =?utf-8?B?N2QyUXc5N2VEb0RkVS9MNGtmZ2NkTk9scEpUbkRlZmYvK0o2dFpKTEZPYzQw?=
 =?utf-8?B?QW5zdFNzb3lITFIrdk1LWnN6VmJFeHVTVU5tb1Q3SjNZYjJvSDdqT21OYmRi?=
 =?utf-8?B?b2EzMDNMTDRaN2xmbS8xdldtcnBWeDBzOUdNd1NuTXh3M0hGRGs0allPU29B?=
 =?utf-8?B?dk9MRjJRL1QxcHpOc2phL3ZaeXp3aDFPMWdmZUFPTHl2cTl5K2J6RjZSclRZ?=
 =?utf-8?B?RzF2TFdGeGlRZ1Y5VW11Y2s0YW9UK0hnenFYbHhyOFdMUzNQQndrZU1Rbzh1?=
 =?utf-8?B?clZQKzFad25Pd29PSDI1M2RIZkNLQmFCblZsMmQyWXRCNmFaVzJ4YzdwcFBt?=
 =?utf-8?B?dlZVLzRKSzg0UzhyMTViMnUvbXRqbWJFZWEyOEVMYlRlSGZCRmFpM28xdEtr?=
 =?utf-8?B?eW1sc2loWUVQM1I0VzV6Z2k5MVlPNUVwUXdSZG1Xem42QWdOTXZjcEZBVDB6?=
 =?utf-8?B?TFZlbWw0NVltOG1JeE5QMFcrR3JtMER2c1hEUUptc1dkR1E5Wk90cGJNVGVZ?=
 =?utf-8?B?U3BXU24rTHIva1FLSE1GTWdzMkg3NUFZS09adlZMMGFPMzJUZGZBT3dzK3ZK?=
 =?utf-8?B?clArdkNKYWI4S054WS96SjZsanRTT3FvYi9KdW12Y0Y5Y2tqN2tBNDRLay9v?=
 =?utf-8?B?VFM1UmlKQ1I3MVJsVmFIUkV5SC80UFhWa1ZpRWwzbEJrTlRBdHZpN0krcXFM?=
 =?utf-8?Q?5Pjzk2N9pKzni?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU4zWkMyUi8yallCNG80RjlFeUNSK2ZoZVYzeUx5ZDBUbHpxeWFqMGdYeXdW?=
 =?utf-8?B?K3EzRXJwS0lHWHVuMEd1YnFaczYzS0pDaHQ5bXFhZWxmcngxaE1RL3pudzNq?=
 =?utf-8?B?TTVCRlJ5NjR4YklObHZOaTNLRFhEUkNmUC8rWGdmRlVUaE5VMGx0TWdTN1E3?=
 =?utf-8?B?L0hmU2RqeW5uODRvcG54amhhTEtva3d4WkZTWkFxSVJka3VhNG5zQnk4RHVF?=
 =?utf-8?B?Yyt0RERvNjl5N24za2l3M21jNC9uN1NmVDMxNmF3cmNtWStBRWhnK2lUTzY1?=
 =?utf-8?B?MnpJSUVjcnBQSSticklYZU9zTnREUWNHbWNyWjdMM3UvL0JMRmYzOTdBQ1dD?=
 =?utf-8?B?YXZ3V1FIYXd4aFpQY1BMUVY1dkpvVlZwRkdZSXhWV2FnTE9FWGQwdkhHbVVk?=
 =?utf-8?B?VEhjMDd4T1BWNVUvd3ljNTZnREZMVmp4L3hvU3NxUktYUHIyQ1VoVGE1RjJY?=
 =?utf-8?B?VFd4VTVNdEtYbnlaSTJKRU1KVWJSRnNiNnJGUXdBRytTc0F3MzhLQ25GcitM?=
 =?utf-8?B?aEVmdDcrVEVLbVJLVUtTZUpwMncwTkUxWXdEVkR3eHZUQjVlMkRzR1ZyS3lZ?=
 =?utf-8?B?ZUN1aDBWSTc3b2NLOHpub3JMT3dub250K3pWTEcxaW9tY3YxQ1BJR1ZqelJZ?=
 =?utf-8?B?dDhpRndIRWxScGRtN2JKSVBvVzZUM2dsNUVSY1A5Z1V6WGhBMkc5M256TEJO?=
 =?utf-8?B?VUVvWGxINytsb2ZVQlJaTXBaY1RXYjRseG1PM3NidWkwdFAxK3V6TGZSL2pT?=
 =?utf-8?B?VVVDRW9XM0JRV3I3NHZrL3c5U0tpemNQL2FvVVUvTndrVC9jOGR0dTZmZUNt?=
 =?utf-8?B?ZnV3Z3BFUFgwVmxMaWlJNk1MeXA1SnJLYnBLOFJZbnpSeENYbGxBcnFWdlBn?=
 =?utf-8?B?dmVZUk9oaFl0bWo0eEdEOVdCL2VYMCtHUktVNCt1dTFpWko2amFCYXRyR21y?=
 =?utf-8?B?dUU5UHhEMjUxblNmOUlBVzhIMStHczVUVEFVUGZqK3IxaG1CZHV4eldIMU1k?=
 =?utf-8?B?Wis2Y1Z1UEd3TWd2ZUxnUVd1akUrRVBWaW5kbjhMbkp3aGM5UkxrV2xrZWsy?=
 =?utf-8?B?empqSzdJWjFmYVJpUEM3Uk82NWhFZGllWUlLZGF2WVhXZy9ROUoxd0FLM2RS?=
 =?utf-8?B?NHgzY3o3UElMaEh0eEhrZkc5UzQ0bzZLQTVlWTBmbVhKY3NuYnUrd1hyQzJs?=
 =?utf-8?B?Vm1hNHk3UFJiVlJxWWJFcDMrMk43TTljd3hoeUQ3R1RzaC8xV1ZtYk03YVQ2?=
 =?utf-8?B?TVdIMG11N21NWFN6M0t2N1RESDVLK2NERU9pak9sc2pjNTZtbm8xbVBKNDMv?=
 =?utf-8?B?ZnN0dXlaYjV3MWF2N0t6U0lhL3AyTVlZTXFCYjNvc2ljcDNnVmFzYVlyZ0dJ?=
 =?utf-8?B?N3k2WDUrcFdRd1hTM01UNC8zcTB6M1RaK1dOSWxpZWp2YUxYd0lIcUJ3QVB4?=
 =?utf-8?B?Uy9CQWdZQ2RMaVZQdDNBaENZVTZzV29kNGgzN3RMSXpqU09FQ25vM3d6T1Ny?=
 =?utf-8?B?OUZlbGxoaFcydjJnYytZUEgvNmtlai9lQ1VQdVM5MmY5ek9lVjRhb1B1SGln?=
 =?utf-8?B?UjY4bmEvOFB6S1poZWFFR0MxTDI2QnhFOFJ2SGM1SEFzRmNaY0MzUythaUh1?=
 =?utf-8?B?dTliRmdjeHVHRGdGai9uelk3c2lTYVRUU2swR2VPazhiT2dXNmVzOUVXVXln?=
 =?utf-8?B?emk1c2s1a2ZraEtsM1VpckdMeHdUWGloZkdPS280OXY3VkNwWjdtYmxjbFVm?=
 =?utf-8?B?Ujh5SkttUDJpeXFuMVRsWGdMU0JpK3NEYmdmVFdxeDZsY1VLM1NZNWdGdVYy?=
 =?utf-8?B?K2RsMTQrR29kY3JqL0NLdkRKSjlsaXRCMS9Ld082OC9HZHRtTDRsMHR4K3k2?=
 =?utf-8?B?c3p3MTB6ZW02MzVZc1dvNVNIZWtsaVg4aWtoU2Z2bmszbVdXZVY1eXJGeEJS?=
 =?utf-8?B?VldjenhFL0lxMlhZNHVXdHdTVnkxWVdabXlqam1OOURxbmFOZzQ1MU90MlBJ?=
 =?utf-8?B?a0NrRXY3VnQ0aUpmNVdxRTBEM1g2WkNPRmphR2daS0p6b0hXVXYxWjlDZXZH?=
 =?utf-8?B?anFFaUIvSStpZFlteEp2Y3p5eGE1WWRocGkrZTkzMm0xbGgxU2FWbWlPV0w5?=
 =?utf-8?Q?TozquSwffNGkjsORTSavR4oTE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605e8890-9267-4356-f422-08dd5b5977c9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 20:16:37.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfGckH2ir+1mhY0hGRrYYAQ4TER6W0sUpTxdo+2q6a8nkyMfAl0GpkZzfUMGcGBMOSPZLZ1JX3baSbVnu9Ki1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087



On 3/4/2025 11:57 AM, Yazen Ghannam wrote:
> On Wed, Feb 26, 2025 at 10:11:56PM +0000, Smita Koralahalli wrote:
> 
> [...]
> 
>> +static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>> +{
>> +	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>> +				       data->prot_err.agent_addr.function);
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>> +					    data->prot_err.agent_addr.bus,
>> +					    devfn);
>> +
>> +	guard(device)(&pdev->dev);
>> +	if (!pdev)
>> +		return;
>> +
> 
> If 'pdev == NULL', then there would be a NULL pointer dereference in the
> guard() statement, IIUC.
> 
> So I think the guard() statement should go after the NULL pointer check.

This is such a blunder. Thanks for pointing out Yazen. Let me fix in 
next revision.

Thanks
Smita
> 
> Thanks,
> Yazen


