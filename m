Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276CD43D298
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhJ0UPM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 16:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbhJ0UNB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Oct 2021 16:13:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B9C061767
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 13:10:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id d23so5347831ljj.10
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W77LeKdotuSb/MvmVYSgYuopSos/uUoqQkzkXzfiwwM=;
        b=ATWPxb37v0dadY6+4F8y022qYdPGufdqR6DH/1fbdEYAHDZsSn8ZkFfb/hoFX2Vt2i
         sULlxBBPs6f0n2jwgBafIqIpptzy1KYN7PbRPdR7sgmXLc9r0giuQZfg2v2f10T0CShh
         UAj5w6Idd3tgog2+k0XOyBy8iuCRguAqSmurPpApS8mkL4gopFczdDXWttew1iAy7R5k
         NHCPNs6HNeBBr8uyAghB8Zy/fMugpv/FiOB9Qi6xsbHXG0iNEZdsBAxLh2osF/5Y1Ai9
         DlGisfc3BrlGSw3oDR3TusMvW9DFrDJuuE5/YlarslNtILrSbNrdcHH0r80sqFaO5Lrk
         dNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W77LeKdotuSb/MvmVYSgYuopSos/uUoqQkzkXzfiwwM=;
        b=o7T7OKpwLTr0+Fif9weD1hEbaQOAwzC090dcyG7awscMUuJGNkoqII6q+poN4hZfcI
         sOsL19uLoSnaDAOYBOuA2S9LcxbLHnkOBRu8RyMKXdmBXhXMq8eyQ56YcawxJJxVVrRl
         tcfkXrEwuKXMjUm3CYml/fwL7Vrwt13vbSFkGfPfXaynvXCLl1dYdopW+7JW3fsiw102
         yV7HmpRMPLw/nX2wUwPNQvUIb2vgYHqL4FPlhDIHbb/IYUB0jAKwxYbObtYtyLht9fHt
         mBI796+G680sG4UmfRLlBivDVADozV+ruEJEaWV/gPSMMK3Ry8QkN6+5gc27ecQast5d
         Q6SQ==
X-Gm-Message-State: AOAM531JG3441OJhCkObjvR/j9s7m7kBwp7cEsXRVRMEdJr4f7CMHRYm
        i1w96yKolA5QuEQtH8q35sWUT3T4CxzhBB9/On7cmg==
X-Google-Smtp-Source: ABdhPJzZYR3m/Nivm3InJdPzx/RQkc7eGvk++BCtdpT+q+JqE3ZU3tXpchZXgLxihr4I2UyyZ3hnDVe6ZUnnWMlCr/o=
X-Received: by 2002:a2e:b7ca:: with SMTP id p10mr13100ljo.278.1635365432957;
 Wed, 27 Oct 2021 13:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-41-brijesh.singh@amd.com> <CAMkAt6rPVsJpvdzwG3Keu3gv=n0hmYdDpYJMVoDP7XgwzvH7vQ@mail.gmail.com>
 <bf55b53c-cc3d-f2c3-cf21-df6fb4882e13@amd.com>
In-Reply-To: <bf55b53c-cc3d-f2c3-cf21-df6fb4882e13@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 27 Oct 2021 14:10:20 -0600
Message-ID: <CAMkAt6pCSNZiB7zVXp=70fF-qORZT0D5KCSY=GrJU0iiLZN_Mw@mail.gmail.com>
Subject: Re: [PATCH v6 40/42] virt: Add SEV-SNP guest driver
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, Marc Orr <marcorr@google.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 27, 2021 at 10:08 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> Hi Peter,
>
> Somehow this email was filtered out as spam and never reached to my
> inbox. Sorry for the delay in the response.
>
> On 10/20/21 4:33 PM, Peter Gonda wrote:
> > On Fri, Oct 8, 2021 at 12:06 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
> >>
> >> SEV-SNP specification provides the guest a mechanisum to communicate with
> >> the PSP without risk from a malicious hypervisor who wishes to read, alter,
> >> drop or replay the messages sent. The driver uses snp_issue_guest_request()
> >> to issue GHCB SNP_GUEST_REQUEST or SNP_EXT_GUEST_REQUEST NAE events to
> >> submit the request to PSP.
> >>
> >> The PSP requires that all communication should be encrypted using key
> >> specified through the platform_data.
> >>
> >> The userspace can use SNP_GET_REPORT ioctl() to query the guest
> >> attestation report.
> >>
> >> See SEV-SNP spec section Guest Messages for more details.
> >>
> >> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> >> ---
> >>   Documentation/virt/coco/sevguest.rst  |  77 ++++
> >>   drivers/virt/Kconfig                  |   3 +
> >>   drivers/virt/Makefile                 |   1 +
> >>   drivers/virt/coco/sevguest/Kconfig    |   9 +
> >>   drivers/virt/coco/sevguest/Makefile   |   2 +
> >>   drivers/virt/coco/sevguest/sevguest.c | 561 ++++++++++++++++++++++++++
> >>   drivers/virt/coco/sevguest/sevguest.h |  98 +++++
> >>   include/uapi/linux/sev-guest.h        |  44 ++
> >>   8 files changed, 795 insertions(+)
> >>   create mode 100644 Documentation/virt/coco/sevguest.rst
> >>   create mode 100644 drivers/virt/coco/sevguest/Kconfig
> >>   create mode 100644 drivers/virt/coco/sevguest/Makefile
> >>   create mode 100644 drivers/virt/coco/sevguest/sevguest.c
> >>   create mode 100644 drivers/virt/coco/sevguest/sevguest.h
> >>   create mode 100644 include/uapi/linux/sev-guest.h
> >>
> >> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
> >> new file mode 100644
> >> index 000000000000..002c90946b8a
> >> --- /dev/null
> >> +++ b/Documentation/virt/coco/sevguest.rst
> >> @@ -0,0 +1,77 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +===================================================================
> >> +The Definitive SEV Guest API Documentation
> >> +===================================================================
> >> +
> >> +1. General description
> >> +======================
> >> +
> >> +The SEV API is a set of ioctls that are used by the guest or hypervisor
> >> +to get or set certain aspect of the SEV virtual machine. The ioctls belong
> >> +to the following classes:
> >> +
> >> + - Hypervisor ioctls: These query and set global attributes which affect the
> >> +   whole SEV firmware.  These ioctl are used by platform provision tools.
> >> +
> >> + - Guest ioctls: These query and set attributes of the SEV virtual machine.
> >> +
> >> +2. API description
> >> +==================
> >> +
> >> +This section describes ioctls that can be used to query or set SEV guests.
> >> +For each ioctl, the following information is provided along with a
> >> +description:
> >> +
> >> +  Technology:
> >> +      which SEV techology provides this ioctl. sev, sev-es, sev-snp or all.
> >> +
> >> +  Type:
> >> +      hypervisor or guest. The ioctl can be used inside the guest or the
> >> +      hypervisor.
> >> +
> >> +  Parameters:
> >> +      what parameters are accepted by the ioctl.
> >> +
> >> +  Returns:
> >> +      the return value.  General error numbers (ENOMEM, EINVAL)
> >> +      are not detailed, but errors with specific meanings are.
> >> +
> >> +The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
> >> +The ioctl accepts struct snp_user_guest_request. The input and output structure is
> >> +specified through the req_data and resp_data field respectively. If the ioctl fails
> >> +to execute due to a firmware error, then fw_err code will be set.
> >> +
> >> +::
> >> +        struct snp_guest_request_ioctl {
> >> +                /* Request and response structure address */
> >> +                __u64 req_data;
> >> +                __u64 resp_data;
> >> +
> >> +                /* firmware error code on failure (see psp-sev.h) */
> >> +                __u64 fw_err;
> >> +        };
> >> +
> >> +2.1 SNP_GET_REPORT
> >> +------------------
> >> +
> >> +:Technology: sev-snp
> >> +:Type: guest ioctl
> >> +:Parameters (in): struct snp_report_req
> >> +:Returns (out): struct snp_report_resp on success, -negative on error
> >> +
> >> +The SNP_GET_REPORT ioctl can be used to query the attestation report from the
> >> +SEV-SNP firmware. The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command
> >> +provided by the SEV-SNP firmware to query the attestation report.
> >> +
> >> +On success, the snp_report_resp.data will contains the report. The report
> >> +will contain the format described in the SEV-SNP specification. See the SEV-SNP
> >> +specification for further details.
> >> +
> >> +
> >> +Reference
> >> +---------
> >> +
> >> +SEV-SNP and GHCB specification: developer.amd.com/sev
> >> +
> >> +The driver is based on SEV-SNP firmware spec 0.9 and GHCB spec version 2.0.
> >> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> >> index 8061e8ef449f..e457e47610d3 100644
> >> --- a/drivers/virt/Kconfig
> >> +++ b/drivers/virt/Kconfig
> >> @@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
> >>   source "drivers/virt/nitro_enclaves/Kconfig"
> >>
> >>   source "drivers/virt/acrn/Kconfig"
> >> +
> >> +source "drivers/virt/coco/sevguest/Kconfig"
> >> +
> >>   endif
> >> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> >> index 3e272ea60cd9..9c704a6fdcda 100644
> >> --- a/drivers/virt/Makefile
> >> +++ b/drivers/virt/Makefile
> >> @@ -8,3 +8,4 @@ obj-y                           += vboxguest/
> >>
> >>   obj-$(CONFIG_NITRO_ENCLAVES)   += nitro_enclaves/
> >>   obj-$(CONFIG_ACRN_HSM)         += acrn/
> >> +obj-$(CONFIG_SEV_GUEST)                += coco/sevguest/
> >> diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
> >> new file mode 100644
> >> index 000000000000..96190919cca8
> >> --- /dev/null
> >> +++ b/drivers/virt/coco/sevguest/Kconfig
> >> @@ -0,0 +1,9 @@
> >> +config SEV_GUEST
> >> +       tristate "AMD SEV Guest driver"
> >> +       default y
> >> +       depends on AMD_MEM_ENCRYPT && CRYPTO_AEAD2
> >> +       help
> >> +         The driver can be used by the SEV-SNP guest to communicate with the PSP to
> >> +         request the attestation report and more.
> >> +
> >> +         If you choose 'M' here, this module will be called sevguest.
> >> diff --git a/drivers/virt/coco/sevguest/Makefile b/drivers/virt/coco/sevguest/Makefile
> >> new file mode 100644
> >> index 000000000000..b1ffb2b4177b
> >> --- /dev/null
> >> +++ b/drivers/virt/coco/sevguest/Makefile
> >> @@ -0,0 +1,2 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +obj-$(CONFIG_SEV_GUEST) += sevguest.o
> >> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> >> new file mode 100644
> >> index 000000000000..2d313fb2ffae
> >> --- /dev/null
> >> +++ b/drivers/virt/coco/sevguest/sevguest.c
> >> @@ -0,0 +1,561 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * AMD Secure Encrypted Virtualization Nested Paging (SEV-SNP) guest request interface
> >> + *
> >> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> >> + *
> >> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/types.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/io.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/miscdevice.h>
> >> +#include <linux/set_memory.h>
> >> +#include <linux/fs.h>
> >> +#include <crypto/aead.h>
> >> +#include <linux/scatterlist.h>
> >> +#include <linux/psp-sev.h>
> >> +#include <uapi/linux/sev-guest.h>
> >> +#include <uapi/linux/psp-sev.h>
> >> +
> >> +#include <asm/svm.h>
> >> +#include <asm/sev.h>
> >> +
> >> +#include "sevguest.h"
> >> +
> >> +#define DEVICE_NAME    "sev-guest"
> >> +#define AAD_LEN                48
> >> +#define MSG_HDR_VER    1
> >> +
> >> +struct snp_guest_crypto {
> >> +       struct crypto_aead *tfm;
> >> +       u8 *iv, *authtag;
> >> +       int iv_len, a_len;
> >> +};
> >> +
> >> +struct snp_guest_dev {
> >> +       struct device *dev;
> >> +       struct miscdevice misc;
> >> +
> >> +       struct snp_guest_crypto *crypto;
> >> +       struct snp_guest_msg *request, *response;
> >> +       struct snp_secrets_page_layout *layout;
> >> +       struct snp_req_data input;
> >> +       u32 *os_area_msg_seqno;
> >> +};
> >> +
> >> +static u32 vmpck_id;
> >> +module_param(vmpck_id, uint, 0444);
> >> +MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
> >> +
> >> +static DEFINE_MUTEX(snp_cmd_mutex);
> >> +
> >> +static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> >> +{
> >> +       u64 count;
> >> +
> >> +       /* Read the current message sequence counter from secrets pages */
> >> +       count = *snp_dev->os_area_msg_seqno;
> >> +
> >> +       return count + 1;
> >> +}
> >> +
> >> +/* Return a non-zero on success */
> >> +static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> >> +{
> >> +       u64 count = __snp_get_msg_seqno(snp_dev);
> >> +
> >> +       /*
> >> +        * The message sequence counter for the SNP guest request is a  64-bit
> >> +        * value but the version 2 of GHCB specification defines a 32-bit storage
> >> +        * for the it. If the counter exceeds the 32-bit value then return zero.
> >> +        * The caller should check the return value, but if the caller happen to
> >> +        * not check the value and use it, then the firmware treats zero as an
> >> +        * invalid number and will fail the  message request.
> >> +        */
> >> +       if (count >= UINT_MAX) {
> >> +               pr_err_ratelimited("SNP guest request message sequence counter overflow\n");
> >> +               return 0;
> >> +       }
> >> +
> >> +       return count;
> >> +}
> >> +
> >> +static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
> >> +{
> >> +       /*
> >> +        * The counter is also incremented by the PSP, so increment it by 2
> >> +        * and save in secrets page.
> >> +        */
> >> +       *snp_dev->os_area_msg_seqno += 2;
> >> +}
> >> +
> >> +static inline struct snp_guest_dev *to_snp_dev(struct file *file)
> >> +{
> >> +       struct miscdevice *dev = file->private_data;
> >> +
> >> +       return container_of(dev, struct snp_guest_dev, misc);
> >> +}
> >> +
> >> +static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
> >> +{
> >> +       struct snp_guest_crypto *crypto;
> >> +
> >> +       crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
> >> +       if (!crypto)
> >> +               return NULL;
> >> +
> >> +       crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
> >> +       if (IS_ERR(crypto->tfm))
> >> +               goto e_free;
> >> +
> >> +       if (crypto_aead_setkey(crypto->tfm, key, keylen))
> >> +               goto e_free_crypto;
> >> +
> >> +       crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
> >> +       if (crypto->iv_len < 12) {
> >> +               dev_err(snp_dev->dev, "IV length is less than 12.\n");
> >> +               goto e_free_crypto;
> >> +       }
> >> +
> >> +       crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
> >> +       if (!crypto->iv)
> >> +               goto e_free_crypto;
> >> +
> >> +       if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
> >> +               if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
> >> +                       dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
> >> +                       goto e_free_crypto;
> >> +               }
> >> +       }
> >> +
> >> +       crypto->a_len = crypto_aead_authsize(crypto->tfm);
> >> +       crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
> >> +       if (!crypto->authtag)
> >> +               goto e_free_crypto;
> >> +
> >> +       return crypto;
> >> +
> >> +e_free_crypto:
> >> +       crypto_free_aead(crypto->tfm);
> >> +e_free:
> >> +       kfree(crypto->iv);
> >> +       kfree(crypto->authtag);
> >> +       kfree(crypto);
> >> +
> >> +       return NULL;
> >> +}
> >> +
> >> +static void deinit_crypto(struct snp_guest_crypto *crypto)
> >> +{
> >> +       crypto_free_aead(crypto->tfm);
> >> +       kfree(crypto->iv);
> >> +       kfree(crypto->authtag);
> >> +       kfree(crypto);
> >> +}
> >> +
> >> +static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
> >> +                          u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
> >> +{
> >> +       struct snp_guest_msg_hdr *hdr = &msg->hdr;
> >> +       struct scatterlist src[3], dst[3];
> >> +       DECLARE_CRYPTO_WAIT(wait);
> >> +       struct aead_request *req;
> >> +       int ret;
> >> +
> >> +       req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
> >> +       if (!req)
> >> +               return -ENOMEM;
> >> +
> >> +       /*
> >> +        * AEAD memory operations:
> >> +        * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
> >> +        * |  msg header      |  plaintext       |  hdr->authtag  |
> >> +        * | bytes 30h - 5Fh  |    or            |                |
> >> +        * |                  |   cipher         |                |
> >> +        * +------------------+------------------+----------------+
> >> +        */
> >> +       sg_init_table(src, 3);
> >> +       sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
> >> +       sg_set_buf(&src[1], src_buf, hdr->msg_sz);
> >> +       sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
> >> +
> >> +       sg_init_table(dst, 3);
> >> +       sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
> >> +       sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
> >> +       sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
> >> +
> >> +       aead_request_set_ad(req, AAD_LEN);
> >> +       aead_request_set_tfm(req, crypto->tfm);
> >> +       aead_request_set_callback(req, 0, crypto_req_done, &wait);
> >> +
> >> +       aead_request_set_crypt(req, src, dst, len, crypto->iv);
> >> +       ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
> >> +
> >> +       aead_request_free(req);
> >> +       return ret;
> >> +}
> >> +
> >> +static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
> >> +                        void *plaintext, size_t len)
> >> +{
> >> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
> >> +       struct snp_guest_msg_hdr *hdr = &msg->hdr;
> >> +
> >> +       memset(crypto->iv, 0, crypto->iv_len);
> >> +       memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> >> +
> >> +       return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
> >> +}
> >> +
> >> +static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
> >> +                      void *plaintext, size_t len)
> >> +{
> >> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
> >> +       struct snp_guest_msg_hdr *hdr = &msg->hdr;
> >> +
> >> +       /* Build IV with response buffer sequence number */
> >> +       memset(crypto->iv, 0, crypto->iv_len);
> >> +       memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> >> +
> >> +       return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
> >> +}
> >> +
> >> +static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
> >> +{
> >> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
> >> +       struct snp_guest_msg *resp = snp_dev->response;
> >> +       struct snp_guest_msg *req = snp_dev->request;
> >> +       struct snp_guest_msg_hdr *req_hdr = &req->hdr;
> >> +       struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
> >> +
> >> +       dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
> >> +               resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
> >> +
> >> +       /* Verify that the sequence counter is incremented by 1 */
> >> +       if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
> >> +               return -EBADMSG;
> >> +
> >> +       /* Verify response message type and version number. */
> >> +       if (resp_hdr->msg_type != (req_hdr->msg_type + 1) ||
> >> +           resp_hdr->msg_version != req_hdr->msg_version)
> >> +               return -EBADMSG;
> >> +
> >> +       /*
> >> +        * If the message size is greater than our buffer length then return
> >> +        * an error.
> >> +        */
> >> +       if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
> >> +               return -EBADMSG;
> >> +
> >> +       return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
> >> +}
> >> +
> >> +static bool enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
> >> +                       void *payload, size_t sz)
> >> +{
> >> +       struct snp_guest_msg *req = snp_dev->request;
> >> +       struct snp_guest_msg_hdr *hdr = &req->hdr;
> >> +
> >> +       memset(req, 0, sizeof(*req));
> >> +
> >> +       hdr->algo = SNP_AEAD_AES_256_GCM;
> >> +       hdr->hdr_version = MSG_HDR_VER;
> >> +       hdr->hdr_sz = sizeof(*hdr);
> >> +       hdr->msg_type = type;
> >> +       hdr->msg_version = version;
> >> +       hdr->msg_seqno = seqno;
> >> +       hdr->msg_vmpck = vmpck_id;
> >> +       hdr->msg_sz = sz;
> >> +
> >> +       /* Verify the sequence number is non-zero */
> >> +       if (!hdr->msg_seqno)
> >> +               return -ENOSR;
> >> +
> >> +       dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
> >> +               hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
> >> +
> >> +       return __enc_payload(snp_dev, req, payload, sz);
> >> +}
> >> +
> >> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
> >> +                               u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> >> +                               u32 resp_sz, __u64 *fw_err)
> >> +{
> >> +       unsigned long err;
> >> +       u64 seqno;
> >> +       int rc;
> >> +
> >> +       /* Get message sequence and verify that its a non-zero */
> >> +       seqno = snp_get_msg_seqno(snp_dev);
> >> +       if (!seqno)
> >> +               return -EIO;
> >> +
> >> +       memset(snp_dev->response, 0, sizeof(*snp_dev->response));
> >> +
> >> +       /* Encrypt the userspace provided payload */
> >> +       rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       /* Call firmware to process the request */
> >> +       rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> >> +       if (fw_err)
> >> +               *fw_err = err;
> >> +
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       /* Increment to new message sequence after the command is successful. */
> >> +       snp_inc_msg_seqno(snp_dev);
> >
> > Thanks for updating this sequence number logic. But I still have some
> > concerns. In verify_and_dec_payload() we check the encryption header
> > but all these fields are accessible to the hypervisor, meaning it can
> > change the header and cause this sequence number to not get
> > incremented. We then will reuse the sequence number for the next
> > command, which isn't great for AES GCM. It seems very hard to tell if
> > the FW actually got our request and created a response there by
> > incrementing the sequence number by 2, or if the hypervisor is acting
> > in bad faith. It seems like to be safe we need to completely stop
> > using this vmpck if we cannot confirm the PSP has gotten our request
> > and created a response. Thoughts?
> >
>
> Very good point, I think we can detect this condition by rearranging the
> checks. The verify_and_dec_payload() is called only after the command is
> succesful and does the following checks
>
> 1) Verifies the header
> 2) Decrypts the payload
> 3) Later we increment the sequence
>
> If we arrange to the below order then we can avoid this condition.
> 1) Decrypt the payload
> 2) Increment the sequence number
> 3) Verify the header
>
> The descryption will succeed only if PSP constructed the payload.
>
> Does this make sense ?

Either ordering seems fine to me. I don't think it changes much though
since the header (bytes 30-50 according to the spec) are included in
the authenticated data of the encryption. So any hypervisor modictions
will lead to a decryption failure right?

Either case if we do fail the decryption, what are your thoughts on
not allowing further use of that VMPCK?

>
> thanks
