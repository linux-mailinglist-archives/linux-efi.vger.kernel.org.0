Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28F1269799
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 23:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgINVVA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 17:21:00 -0400
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:6113
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbgINVU7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 17:20:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkvoA7Bo81u/RRjsvmxbnHzfInbdvgAMhhP4ShkmCIrdpm8DvmU2sYCh9yPUdGbwv6n6Owh2eNm+Fg2YcRvHd2rDmwjuGz7T+hA7Jma6+0urqJ6VBPQvidbrg6HYJMqz1nqons067yXg8udylTVA6N9bYc14w9IQauDj2AJV0DDxdcV1RyNi49JH/26Frb73Won7vB0PVpG7RhLsqf+qnjlP8xUfWpjdlI+c858aT15xwt1uK8EzrCGa57m768aPiwMVURAS4/LE9ZL5BktXV7bU3CahB5bjMzrLXuUGAPxhcDVhrG4oNpLILNY2CttEnLwy6OD9dX2uy7MoSx4sMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv/mJROghYOgyqWCcjUXNHAnuF7EFOFH5POhMTHmyf4=;
 b=kLD7VX/k6xEeu94qUv2K2tzfOCHAEUPJvWmhvo+CQLlW/Hl8TWpkzGYq03SFSVNuGkDEnh4tmOE7H5j2jBBnxgMBqLuu8HCmLa8WXB2zCg7O69GPStB5mFlD4IkRoxUE6hJEYUg5qcqa3QzmBOfJLuBFR55Bq7dBlzR+pBN9aOIXZ4oUEDl1PYHD3Lio6Q8zA0IwNvT1p/LhM0NSsPyNJyJyfFRacsjrcQ7KYKuqnDwaKcy0rtMWAxAqfw8ulzSjCtv1DjWWbkBM8kzPiS1vCesp40VwRVx1pRh3J4gV8C4rdCN3iOR16zFctjOfq3B7yedZC+lHQ0R0SP+w9vMlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv/mJROghYOgyqWCcjUXNHAnuF7EFOFH5POhMTHmyf4=;
 b=naEMHrcfGKXd+4k5JL8xU0lOgFnJqhu+fzOKXIHnVTj21WxBZL2aD/dXWgXJCt3GqpWeUxwQ8m8D7Wwcgvs/D1EzCJRGJf5NMRei2BlQf5EPu9pKsfxCO4L0GwHEwW5r+GmucL0xvxM+2gXAuYtlveQLkAeCodOy4ETKRY1yVRg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 21:20:55 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 21:20:55 +0000
Subject: Re: [PATCH v3 2/2] x86/mce/dev-mcelog: Fix updating kflags in AMD
 systems
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200903234531.162484-3-Smita.KoralahalliChannabasappa@amd.com>
 <20200914153420.GD680@zn.tnic>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <ca40b30a-5115-0e89-ff7d-8a0e9fe70bca@amd.com>
Date:   Mon, 14 Sep 2020 16:20:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <20200914153420.GD680@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0139.namprd05.prod.outlook.com
 (2603:10b6:803:2c::17) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (72.182.84.89) by SN4PR0501CA0139.namprd05.prod.outlook.com (2603:10b6:803:2c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Mon, 14 Sep 2020 21:20:54 +0000
X-Originating-IP: [72.182.84.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f454b97-5f13-4ddd-c0c9-08d858f410d4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525057BF543523F5FD30CEC90230@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HwKQYK7ECsC07vjmYnKifuZ2Kma1vIF5icreKEfzv87X8+dCXN2fMsxNMpeoY3VQA4nyTVxG6MhuPyRRDE8wEinej5Q06LSbI6kEhW/jym9+VOiBje+kZhp+h+vzpU/frkwgnoSWl3D+Yd+i8GKFl2WG2JFmBw/IjYnB6io8mM99+thPvq1KtkioMpLY6s8RxmuDkRkKrIW0bd6ZyMPjZL0jVuVSeTEb/nMzLKmjbSAMbI0hupIOn5onGE1gClZT/hEpa2f3v5La+HbfYGys0ePuMwm+wnD3H+Xz2Bm1nb5sClVfHh3KqSzIyRm5DuTBUHi1fxvPMNxiq//l45cfw9eyAQzhSHwvGDCItYbbp/NCPdCuMV8LgiywsaEKJkljOl/4y+hIqIVHt3U4maEZWAn0Y/moBEyVjVBw8mZJxzNN5LmOnM3Ixlwi94iM7avGcNuy5WJ0aGQWardl00spA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(54906003)(26005)(53546011)(2616005)(16576012)(956004)(316002)(186003)(8676002)(83380400001)(6486002)(478600001)(52116002)(8936002)(31696002)(2906002)(16526019)(966005)(45080400002)(31686004)(66476007)(66556008)(66946007)(36756003)(4326008)(6916009)(7416002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: //9CLQiCgxs7p476qs60R+Th7NtO+bhFbyn+yz6rUxmfk4OoWkrSMOG+qLNf/nAtf5Zmpb5qV4AW2RetmRoIGm93JzIAL/xCcTCDa3dYPMeYrUhkRB5WeslanV3Nkfa0A8adkq05LxaHBqzv45TQsqaOI4ulvp/0Le1/xUb/WmvZRO8pKN+wCWRERwgTcIjiVrP+63fbbWHlcJWa3waCx0JT5CVoehYJ8H8M6oAjW4LApe8Jg/bnc0N2glE7LOZ82iJuLThEJfu2ws75mQaM8Ai5yq/sgSmrOYaKlN8KAks4Z2CDnVhth44AUow+DveLdZEWispUVNeDBiT3p3EkaW9fOMu/bCvxh3fSrXc2vuuHMKBhRDiCg7NX+wCbI0XKJimbVIc7Qtsy/YDObYPwL1xsdDIx2myJG8qFNmRXiYjWG2GJ1gcJkmfT282KUlyZ/ry93PGuyv6Xj/+KMeh4LBZev4mdndCK1efpUl4jfItUogKWZn8/ZKMvONxphxyLv2Aijb0jNikovgb3ewf6vDRMdP1pMlgTgxk9/Avj4GK/jC0DpgwZh5Tx3LxpL/++i0de/Nz2mp6q6xw3QeFN3QkuQyPu5DJIR7My42Urzr2a6SiT+JBxD2YshHrBN0ji3Mwt36brLk7MOIqi56THwQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f454b97-5f13-4ddd-c0c9-08d858f410d4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 21:20:55.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIZl3MEkePpgG9VdI1C65zKlhkCsqQUQgz+TJsF6h7d5B3s5OCfwnIriIaNVc4RCkf2y/rgtbu4f5+2XjgeI6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/14/20 10:34 AM, Borislav Petkov wrote:

> On Thu, Sep 03, 2020 at 06:45:31PM -0500, Smita Koralahalli wrote:
>> The mcelog utility is not commonly used on AMD systems. Therefore, errors
>> logged only by the dev_mce_log() notifier will be missed. This may occur
>> if the EDAC modules are not loaded in which case it's preferable to print
>> the error record by the default notifier.
>>
>> However, the mce->kflags set by dev_mce_log() notifier makes the default
>> notifier to skip over the errors assuming they are processed by
>> dev_mce_log().
>>
>> Do not update kflags in the dev_mce_log() notifier on AMD systems.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> Link:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20200828203332.11129-3-Smita.KoralahalliChannabasappa%40amd.com&amp;data=02%7C01%7CSmita.KoralahalliChannabasappa%40amd.com%7Cc452e9f80fe9459839c708d858c3a763%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637356944652485754&amp;sdata=%2FhYQbBBNld1GtNX8%2FI6PERD0icYfy0e1k5zukQYI%2Fa4%3D&amp;reserved=0
>>
>> v3:
>> 	No change
>> v2:
>> 	No change
>> ---
>>   arch/x86/kernel/cpu/mce/dev-mcelog.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
>> index 03e51053592a..100fbeebdc72 100644
>> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
>> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
>> @@ -67,7 +67,9 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
>>   unlock:
>>   	mutex_unlock(&mce_chrdev_read_mutex);
>>   
>> -	mce->kflags |= MCE_HANDLED_MCELOG;
>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>> +		mce->kflags |= MCE_HANDLED_MCELOG;
>> +
>>   	return NOTIFY_OK;
>>   }
>>   
>> -- 
> This one is not related to your 1/2 so it sounds to me like I should
> take this one now, independently?

Yes, this can be taken independently. I just tagged it along as I came
across the issue of missing error logs while trying to print error
records in the previous patch.

Thanks,
Smita

