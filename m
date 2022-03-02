Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7838C4CA1B5
	for <lists+linux-efi@lfdr.de>; Wed,  2 Mar 2022 11:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiCBKFW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Mar 2022 05:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbiCBKFT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Mar 2022 05:05:19 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB018F61B;
        Wed,  2 Mar 2022 02:04:36 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2229q9aj009476;
        Wed, 2 Mar 2022 10:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SSTo2zwutQqS8CLOb41niC3MNo6la48+xhRkN6n2NQA=;
 b=IHJb59jWV2n6AVqy4QJcw5fcIGW+c5muE1Rh09k7t0/yPSG/9BxWvDdpW/7713J3IXsl
 pDL27VWCV66aHpNOwod6yIDxXFd6EfUli7fJ/eLMNKEHoyMeRbWPezyUIPDPy0gFnD/s
 lsJ/T9owCVHFJviCyrNjPBU+Zr87a5CUOCcHbTMgADf60+Np0jhgDi5o6WIEJAgMxlEW
 K6m+58cVoMNH10Xmm+wgyI97ezc4eQhdFLmd3Xp9Glc3mdSu+qBsCirSJo0hnte+X+mj
 zILR+RHwrDKNEl0DQJ/erlzioCNgm1Cx891RJAla/kx1WJtFClkG+qP3u1XVR3fbjglk 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej425k2xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:03:51 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2229s3tb015691;
        Wed, 2 Mar 2022 10:03:50 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej425k2x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:03:50 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2229x5jP017232;
        Wed, 2 Mar 2022 10:03:49 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3efbua3h7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:03:49 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222A3kKp43581704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 10:03:46 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 760462805A;
        Wed,  2 Mar 2022 10:03:46 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB56628072;
        Wed,  2 Mar 2022 10:03:39 +0000 (GMT)
Received: from [9.160.11.222] (unknown [9.160.11.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 10:03:39 +0000 (GMT)
Message-ID: <c197dc02-b63a-eb45-8e52-275934177d7e@linux.ibm.com>
Date:   Wed, 2 Mar 2022 12:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v11 42/45] virt: Add SEV-SNP guest driver
Content-Language: en-US
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-43-brijesh.singh@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220224165625.2175020-43-brijesh.singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tPmFrfdvKtFIkwgePH8oT6yOpKKelnIg
X-Proofpoint-ORIG-GUID: l_elf4VPUcaG_X9PErd5Ml7SuErEqAB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Brijesh,

On 24/02/2022 18:56, Brijesh Singh wrote:
> The SEV-SNP specification provides the guest a mechanism to communicate
> with the PSP without risk from a malicious hypervisor who wishes to
> read, alter, drop or replay the messages sent. The driver uses
> snp_issue_guest_request() to issue GHCB SNP_GUEST_REQUEST or
> SNP_EXT_GUEST_REQUEST NAE events to submit the request to PSP.
> 
> The PSP requires that all communication should be encrypted using key
> specified through the platform_data.
> 
> Userspace can use SNP_GET_REPORT ioctl() to query the guest attestation
> report.
> 
> See SEV-SNP spec section Guest Messages for more details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---

[...]

> +
> +static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
> +{
> +	struct snp_guest_crypto *crypto;
> +
> +	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
> +	if (!crypto)
> +		return NULL;
> +
> +	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
> +	if (IS_ERR(crypto->tfm))
> +		goto e_free;


When trying this series, the sevguest module didn't load (and printed no
error message).  After adding some debug messages, I found that the
crypto_alloc_read() call returned an error.  I found out that
CONFIG_CRYPTO_GCM was disabled in my config.

Consider modifying sevguest/Kconfig to force it in:



diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
index 2be45820e86c..74ca1fe09437 100644
--- a/drivers/virt/coco/sevguest/Kconfig
+++ b/drivers/virt/coco/sevguest/Kconfig
@@ -1,7 +1,9 @@
 config SEV_GUEST
        tristate "AMD SEV Guest driver"
        default m
-       depends on AMD_MEM_ENCRYPT && CRYPTO_AEAD2
+       depends on AMD_MEM_ENCRYPT
+       select CRYPTO_AEAD2
+       select CRYPTO_GCM
        help
          SEV-SNP firmware provides the guest a mechanism to communicate with
          the PSP without risk from a malicious hypervisor who wishes to read,



Another thing to consider is to add messages to the various error paths
in snp_guest_probe().  Not sure what is the common practice in other modules.

-Dov


> +
> +	if (crypto_aead_setkey(crypto->tfm, key, keylen))
> +		goto e_free_crypto;
> +
> +	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
> +	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
> +	if (!crypto->iv)
> +		goto e_free_crypto;
> +
> +	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
> +		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
> +			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
> +			goto e_free_iv;
> +		}
> +	}
> +
> +	crypto->a_len = crypto_aead_authsize(crypto->tfm);
> +	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
> +	if (!crypto->authtag)
> +		goto e_free_auth;
> +
> +	return crypto;
> +
> +e_free_auth:
> +	kfree(crypto->authtag);
> +e_free_iv:
> +	kfree(crypto->iv);
> +e_free_crypto:
> +	crypto_free_aead(crypto->tfm);
> +e_free:
> +	kfree(crypto);
> +
> +	return NULL;
> +}

[...]
