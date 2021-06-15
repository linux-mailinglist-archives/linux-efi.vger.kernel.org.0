Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A243A7C56
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jun 2021 12:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhFOKrY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Jun 2021 06:47:24 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:50849
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231337AbhFOKrY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Jun 2021 06:47:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loi7BS16hz5QGx+vTtEFC0XcKzhD9bNqIFqgWb5QIxPbgcPowg+GFwCt/qTTmMZ8pIcfvZG19jNIO0HC2mgwUGcEImkojGXRr/iZS8iAgIRhEA499fdmEkSJdYxs36eMALIdi9tPHF1pTlxPCCMf6aeKNznpuN4Ohy7Q1sE5S7k5880t3q9wrNTF1KE+CtKK8PImfFcANVBaBuWFFYBsDtveNFvfCkTcACo3H+i7fsC/0DCmYdDAftJXI3+0so8ktAB0j+OHQBufZYMPMCvpBj8KIlJGpR61jvxMVsZTsxc62mt6qKn29lnbG7Zv7o0dkr03o1g4R/24NB6KRy0/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w6E/bYGycmcQ4fI1TJttyra0azrv5Oo71selCmIX84=;
 b=bR0TyP1F97KAs9mKeOazkPzR4pvQXw0+2O1E4C1wLpVbaUHM3oNK6vLOrNtkn7vGwp5yHIq8Q2gFcezFkZn+Bf+H06ORwV59EWnk8wglX4CS7jMNsAgj4WFSo6p9lytHnHaKw2vdPDMrmxJo8rUQ/DVofxBlapk5Rl+6X9hVltOiOFyQsR9G5IDsa84P2cSXP7YxA2IZRdF0660Yxm1CzyihOtPJLNSDq7t2CU799RzuL5iB6GZaWf9kkDXXGUOq+NvLrdOAxIEk3/AhAiUig1lmaU4lBfmB6PrGqni/8XuyRFVgcHISqQeoilESijz/aFIjsIO3dHTvLboy2kYCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=t2data.com; dmarc=pass action=none header.from=t2data.com;
 dkim=pass header.d=t2data.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t2datacom.onmicrosoft.com; s=selector1-t2datacom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w6E/bYGycmcQ4fI1TJttyra0azrv5Oo71selCmIX84=;
 b=EeaS5vkcxjVZHyFwnZEaTYU62kAPCaX2kI8n2iWKoxro8xixbONgsrurzZgHU/vb1sugUymD+NLtCVAmxsLd7SuFQLMs8oR/NVx2X1buBtUoUEFXsXqlCxTju0VLvo0zu5Pr9Bp2UnWdSbSokBP+wdcVwCdalrANIZEjW7Bkd6g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=t2data.com;
Received: from HE1PR0602MB2858.eurprd06.prod.outlook.com (2603:10a6:3:da::10)
 by HE1PR0602MB2860.eurprd06.prod.outlook.com (2603:10a6:3:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 10:45:16 +0000
Received: from HE1PR0602MB2858.eurprd06.prod.outlook.com
 ([fe80::45ab:82f:2e40:b921]) by HE1PR0602MB2858.eurprd06.prod.outlook.com
 ([fe80::45ab:82f:2e40:b921%10]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 10:45:16 +0000
To:     linux-efi@vger.kernel.org
From:   Christian Melki <christian.melki@t2data.com>
Subject: x86 UEFI stub builtin cpio rootfs.
Message-ID: <dcb66364-d6af-3fc6-05dc-7507acedbb0c@t2data.com>
Date:   Tue, 15 Jun 2021 12:44:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [212.247.174.226]
X-ClientProxiedBy: HE1PR05CA0275.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::27) To HE1PR0602MB2858.eurprd06.prod.outlook.com
 (2603:10a6:3:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.234.94] (212.247.174.226) by HE1PR05CA0275.eurprd05.prod.outlook.com (2603:10a6:3:fc::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend Transport; Tue, 15 Jun 2021 10:45:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9b8a9c9-f564-4f71-a739-08d92feaa988
X-MS-TrafficTypeDiagnostic: HE1PR0602MB2860:
X-Microsoft-Antispam-PRVS: <HE1PR0602MB2860B7588F15F9C5BA1AFF26DA309@HE1PR0602MB2860.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfbKkLNIfnOuymUngXO4hnmFlKAPQL479Az6MMH2nQzF9AEw3OTvEMDvUHxtoeJveyLDf4sn03P+KXkwxdPvHnx4Uby3qlM0CPw/EhstzHLN3J3MdAs025SHu+L6ppUdf0maXbyZm1t5nJgM9lRwBrSxQMM4eU29n7YLHQM1pq2gje7KgfmTYYwGpPMzYr+WgckAgIjIK1EqXWtqc3o5VNwtFEvhOpu8JqNsr2gr8aPPbLeQNN0lPYQtJdo5BKQ2pI103IMUV6sWoOx2rNdlzsUTUCVVZFGlVQauuvzWXcFG6z2OBbYj6sL3Dqkqd/KhQp/3SBnVUhX+MgxdTeWqSfQBF7+24d4IqvMX4XlN868Tlby52guLp5P0fuT5mzn9UVYNdcpM59dZdsy7MiUD00U0eqV/fX1ROjcNN3XzFSzvXvtelvuwkYheFnWMr8wA290L7z0wbp/eshF3ipuVVA8RXamnwF+uj0ZQgFV8lPyi4wuVEO2JM8fRk2vRqpTqsWochVxQs1F1kh8TuQ6koit8uhyEporIuJ35UNklsuBN/XfLxXaQYc9p3FNczz5INvna1TuEMQYgyY5htaTg3vjQtOVILIfD2rhPxKwcZrSXsmOKgqidY2eYp+u9DK06/RFJg+k4YTU1PMV8XoNdjXD0WEMhpsYC4NAj35udZRtL6TwLNsRU7YYcMJwUp1EoB6+CHCA+Ly2OrCdn0aOFpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB2858.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39830400003)(346002)(376002)(42606007)(396003)(6486002)(16526019)(186003)(66476007)(478600001)(31696002)(66556008)(8936002)(26005)(66946007)(38350700002)(36756003)(2616005)(44832011)(8676002)(52116002)(956004)(16576012)(5660300002)(316002)(38100700002)(6916009)(6666004)(2906002)(31686004)(86362001)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlpMaFp0bUNxNGEvb2ppb2hObloxTGpwMENBbTdoa3Q3YnpTRUVSLy84OUFr?=
 =?utf-8?B?MnU3T29xdHRMbzdkeCs4YnB2NTVGTStUaHJvSDdRM1dqUDV2YzZHdFRpVXVp?=
 =?utf-8?B?V3dTazVMVm1la3dFTlpTZzg0QzhEZ2Jaemd3ZElRV0IycmpzYTRacjVrL0Vx?=
 =?utf-8?B?ZEgzYjZ2dXZyeERhYXB2YndJNkE5RE1CWGdienRNTVBhdmwrWER2eGh0UEs4?=
 =?utf-8?B?NjJkYUMxNDkwUWp5MzhhSzEzanNKSWxXdHZ4aHl2NkNXV3pTaEtJbWFjVVJq?=
 =?utf-8?B?UTdSZmxmcUlkOGQ4SHlzeGM1cEFnYWtQNHd3VEFiakpvL2sxazFqSldEVmFL?=
 =?utf-8?B?emo3U3BOeTRSbXBxV0puY09Sajd4TVg1U1dxTmljcERVY0ZoaERnakdxWlR6?=
 =?utf-8?B?enVwU0xaR05yRzlUUFdJSWg1eVByWmpTTk1TSFo1elRPWk9YZDZhNndha29k?=
 =?utf-8?B?cVVIL0xuZklkRXp3MzZFY3o4L0R1YldTNkUrc2l1TkxUQ3Q5NlZLc3NGcEtk?=
 =?utf-8?B?OEV2WExEcjJmdERXbDhWV0NXMnFmREZpNVh5SUowM2l2cHNqc0JtcjBxcVRq?=
 =?utf-8?B?QU1YL1Q1enJ4UElKZmF5QUYzQ2ZEVFlSOXRRWmJCbnc1eTB6eHlmVHRhK0JX?=
 =?utf-8?B?eWJ0UWdFQkV2dnprL2U4UVFBSkZrUEN4c0o1ODlTQS9NMDJQWGZEeHpXTnc5?=
 =?utf-8?B?Y0xLbjBBM2dtenM1NGR3RGNDZVZQc2ZLYnpVOTQveGFhbUYrZDdmSm54dURL?=
 =?utf-8?B?Nld3Z3Q1US8yRVBIbHVCK2o2djY1ZWxXeksvbmFYZGl1NkE0Vjk0c0tIclJT?=
 =?utf-8?B?a1FwTktaM1RrcVZScXkyK1BmbTV6V3RIWkN1dUZvclk0MkUwNnV3TDdWTWIr?=
 =?utf-8?B?Ni8yRVZJdGVUWkVlR3hwYTJ3RVZBK1loeXk1ZTkwN1RpLzVERnh6ZXVaV2pa?=
 =?utf-8?B?QXVRZFZ4UlZFMStJUmwyMXZOVHloWElCbzA3WWtvQWNmc1dOUUdOQzNPSkt0?=
 =?utf-8?B?cUxsazJzaEZrSFdwMHR2SlFVQ09DTFFhUFVrckFJekFzb3BGV3NmUHozNHhq?=
 =?utf-8?B?ODVpQzF1ek00SThzREl2bGR4bFloN2tIVC83QnY4UHNUQ1Jpdkpid2pRUitq?=
 =?utf-8?B?eGVTaHYyWEtwVUQ1ekp2aTRaUjlZSzh5QmdQOEhnenpJM0JvVXI0ci90NXFj?=
 =?utf-8?B?L0NJK1pUOUxob2s3RU9iV1hHRUQ0dVZyd0ZxaFNMR0JUN2lLWHk3NFhYbWhX?=
 =?utf-8?B?R1lpWXBkVG1pb1V1anozbHFmOGlwMjdJa25zWUExZHpxUlZNRThuTXcvd1Fi?=
 =?utf-8?B?RUNMMnRoQ3p0dVJ2dEw3c0FCTFRnN2kvL1lqeDNtMVU4akZXK09yUmxuZ2c4?=
 =?utf-8?B?amNZbjFIa3o5cjJ6TTdUeUtOYVNuNnFYYlF3ckNscmtVOUNjNW5YampYRENP?=
 =?utf-8?B?azhsby9ETTQzZlVwQW53ZGlBV1N4dExXNk0zOFVRalBHSzBCVVhEVitUS3NS?=
 =?utf-8?B?QVhvL1d4d0Q4S1NmYWxTOUVUZWdSelFPQyttekl6cVVyVUFYOXlMTWlFL05t?=
 =?utf-8?B?eVhZVG1RQ0pFMURMdkdYOUhwaThNZ0FVU0hLaXpwcjlMc0JrSVNvVU1jb1Na?=
 =?utf-8?B?Uk9vRHdFcFJSNW9SamV3dk91TXl0UW5OdEplODhvdDhFWXUzc1ZqMjRXemJQ?=
 =?utf-8?B?RlVBb3A1eUpUaFpleXpKQS81STI0clNFSFRWcTNrYjQ0S3hKamp4ZStSYW9G?=
 =?utf-8?Q?yfTWhCDamMGPjDnN7EX/hr1JuPbALLQaiSjxObZ?=
X-OriginatorOrg: t2data.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b8a9c9-f564-4f71-a739-08d92feaa988
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB2858.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:45:16.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 27928da5-aacd-4ba1-9566-c748a6863e6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21f92SwzYXj6L1845UD3gjmQ1GqxGKqOSE9KhZa14d1z7+Cr4fHHTj94g0SsHQVlJ9fzulftp/xOirJoqD/AMfVC5ltIbTU6QsYjX5zc2FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB2860
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Trying to incorporate a cpio archive but I'm having trouble getting the 
kernel to recognize the builtin archive. No printouts regarding initrd 
at all.
Does the x86/UEFI stub/arch support builtin cpios? I can't find any 
documentation suggesting otherwise.
Skimming through the code makes me skeptical however.

What's the state of builin cpio for x86? More spec. for a UEFI stubbed 
kernel?

Regards,
Christian
